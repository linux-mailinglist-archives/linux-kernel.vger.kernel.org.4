Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B395B6F6191
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjECWyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjECWx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:53:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA694690
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:53:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683154433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2fDBKebp1JiAoGTmRNJgDZkgGkfmtNzma/VKZdCMvQ=;
        b=JPOVX5ue5Fo329NVRVOPqHxIz6NFMVoYRH0zhePq1RvmLszmNjqr9JT/YSSWnBEzGwAFkn
        H9JpmSvlO2kuzIH/+Bi8gNMbuoqF93EeXvYl0A4IJ8K8zbHmTyirFJDPdH6d7N9GVELTz9
        AjfIL3DRVMCSTilsADKQRfV26ylDPKoMXoW27F9B3zAqlrocSlrPjv4v2heg/760y75/bh
        LU5aol2IGaHONm8Tv8KbSruY2Rie78/ARmCdlcG+SllbYyBvmq2KdOPHoWDGu6uyOCuTeO
        RLcxFvporqOy/b/Fvf4mpNnLXRy1oPQznF7fDPqkmgLIaYMlwsivo844RJmL9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683154433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2fDBKebp1JiAoGTmRNJgDZkgGkfmtNzma/VKZdCMvQ=;
        b=NVzO+djRPv14XNGwfsL+eYeTdGJL5BsfjKc1HE3hcEtP5cEUNosodpgNklzOJCCn+jBKJU
        UzDKMT2RIJAVhIAA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <ZFLftU4sEgeEaRJe@lothringen>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx> <ZD/uWdz7dKLKlUqH@localhost.localdomain>
 <87jzy42a74.ffs@tglx> <ZFDxph8YDPjwvbej@lothringen> <87y1m652n2.ffs@tglx>
 <ZFLftU4sEgeEaRJe@lothringen>
Date:   Thu, 04 May 2023 00:53:52 +0200
Message-ID: <87pm7h3u2n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04 2023 at 00:27, Frederic Weisbecker wrote:

> On Tue, May 02, 2023 at 02:38:57PM +0200, Thomas Gleixner wrote:
>> Updated patch below.
>> 
>> Thanks,
>
> Looks good from my layperson's eyes, just a doubt about a comment below:
>
>> +
>> +	/*
>> +	 * When switching from periodic to oneshot mode arm the broadcast
>> +	 * device for the next tick.
>> +	 *
>> +	 * If the broadcast device has been replaced in oneshot mode and
>> +	 * the oneshot broadcast mask is not empty, then arm it to expire
>> +	 * immediately in order to reevaluate the next expiring timer.
>> +	 * nexttick is 0 and therefore in the past which will cause the
>
> Is nexttick really in the past? It's set to tick_next_period...

Only in the non-replacement, i.e. the 'from_periodic' codepath, no?

Thanks,

        tglx
