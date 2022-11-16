Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3264762C6C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiKPRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiKPRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:48:48 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F9654C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:48:48 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668620926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmW9WCvz+s/qLEawf6fSBFXtTILAUrT47yXR3/eJuXA=;
        b=gHOya6+ikm8w73hzuv3v8gYs1nwKsVXAiDPYeHh25rYtsls8WnfmYPtLeNtJZoyISRHBLT
        ovYBecRu4QtPVPemAsppXx0Z0S/INA9VcgBZ5hzHUeeWV5EHNPl0dwzYNtsJmLU7qTKEeo
        S+Uoppf66b4Pw0ULuegq2accZeXeKQk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 03/12] KVM: arm64: Block unsafe FF-A calls from the host
Message-ID: <Y3Uiemx6YQxoZWhh@google.com>
References: <20221116170335.2341003-1-qperret@google.com>
 <20221116170335.2341003-4-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116170335.2341003-4-qperret@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, hit send a bit too early. Reviewing the patch itself:

On Wed, Nov 16, 2022 at 05:03:26PM +0000, Quentin Perret wrote:

[...]

> +static bool ffa_call_unsupported(u64 func_id)
> +{
> +	switch (func_id) {
> +	/* Unsupported memory management calls */
> +	case FFA_FN64_MEM_RETRIEVE_REQ:
> +	case FFA_MEM_RETRIEVE_RESP:
> +	case FFA_MEM_RELINQUISH:
> +	case FFA_MEM_OP_PAUSE:
> +	case FFA_MEM_OP_RESUME:
> +	case FFA_MEM_FRAG_RX:
> +	case FFA_FN64_MEM_DONATE:
> +	/* Indirect message passing via RX/TX buffers */
> +	case FFA_MSG_SEND:
> +	case FFA_MSG_POLL:
> +	case FFA_MSG_WAIT:
> +	/* 32-bit variants of 64-bit calls */
> +	case FFA_MSG_SEND_DIRECT_REQ:
> +	case FFA_MSG_SEND_DIRECT_RESP:
> +	case FFA_RXTX_MAP:
> +	case FFA_MEM_DONATE:
> +	case FFA_MEM_RETRIEVE_REQ:
> +		return true;
> +	}
> +
> +	return false;
> +}

Wouldn't an allowlist behave better in this case? While unlikely, you
wouldn't want EL3 implementing some FFA_BACKDOOR_PVM SMC that falls
outside of the denylist and is passed through.

> +bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
> +{
> +	DECLARE_REG(u64, func_id, host_ctxt, 0);
> +	struct arm_smccc_res res;
> +
> +	if (!is_ffa_call(func_id))
> +		return false;
> +
> +	switch (func_id) {
> +	/* Memory management */
> +	case FFA_FN64_RXTX_MAP:
> +	case FFA_RXTX_UNMAP:
> +	case FFA_MEM_SHARE:
> +	case FFA_FN64_MEM_SHARE:
> +	case FFA_MEM_LEND:
> +	case FFA_FN64_MEM_LEND:
> +	case FFA_MEM_RECLAIM:
> +	case FFA_MEM_FRAG_TX:
> +		break;
> +	}

What is the purpose of this switch?

> +
> +	if (!ffa_call_unsupported(func_id))
> +		return false; /* Pass through */

Another (tiny) benefit of implementing an allowlist is that it avoids
the use of double-negative logic like this.

--
Thanks,
Oliver
