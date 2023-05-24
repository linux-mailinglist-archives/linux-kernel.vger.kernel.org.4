Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76370EE86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjEXGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEXGvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:51:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D31A8;
        Tue, 23 May 2023 23:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tHeCHx/MOMVMOZD9oj9+Q6YTtU8wrcycwgwfyfxHFIY=; b=EtZtPKW8TSYwismfcohBDho/P1
        N4gWnd35viIowDvStMYa9OeqlAzPKP4t2uN25NL18atYnIyqOi2g8KYDvxzXIfiZbExJhekl4+LY3
        pAs7BsyRPwzikVP4SG4QH3zHU8+Kit63+0rFj0bg0JKyzPPtH1GATs7MbkKVx+7FEoBhBqRPGFDRm
        dcbzdeEU6FN5zy3fbqVA1MbmENfCXBwLc23m+z5AX7Q54osvOCJDYJdMfOya0kYxFGqQ7YFvQnBu3
        j49yNpWbnJnPWhopSNtvTmmvVXSvENPbXGmxD7l7XmIvFPY/qy4ERsCMg6C+ueod+CAYCiOnj9jsu
        bZtFiyAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iKd-00CX9Z-1L;
        Wed, 24 May 2023 06:50:47 +0000
Date:   Tue, 23 May 2023 23:50:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 2/4] remoteproc: Add TEE support
Message-ID: <ZG2zx+ARLO1a7wh5@infradead.org>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523091350.292221-3-arnaud.pouliquen@foss.st.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:13:48AM +0200, Arnaud Pouliquen wrote:
> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
> +	struct tee_shm *fw_shm;
> +	int ret;
> +
> +	fw_shm = tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw->data, fw->size);
> +	if (IS_ERR(fw_shm)) {
> +		/* Fallback: Try to allocate memory in OP-TEE space */
> +		fw_shm = tee_shm_alloc_kernel_buf(tee_rproc_ctx->tee_ctx, fw->size);

> +EXPORT_SYMBOL(tee_rproc_load_fw);

Please stick to the EXPORT_SYMBOL_GPL of the underlying tee
infrastructure.
