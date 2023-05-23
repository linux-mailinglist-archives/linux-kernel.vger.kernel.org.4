Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092A70D372
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjEWF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjEWFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:55:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10905120;
        Mon, 22 May 2023 22:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eLhUu8UCBd/YYLdOP3ui5b1tEMg7x/uUoMmk7djKCEM=; b=bKvOSi6aMPy7rYVrte/3XLeNHl
        qkBujmdDFFQ6BARVEU2twgXyiyjAwlKGIordV0kMs0H2djtSnYmE8ZurAQqKDqI0qLTOV2imQXtqf
        biZFkYTJUwIarcadZT7ASdLzrmK3LWv4PL6zZPNaPUgMMS//rpRx9e6Hkb0yegUH2yJBZVnZ6LDKt
        GAEfmKpNqlTQ4Kxftj1nvSA2L+Y7YTTWSsKFYBpfUYI5IDz0c8S1LLRY+TasePE9OosWa++5TvrgP
        EjKnONZcCvS0q7YOiTlHucKoDFPzVO94VQc36ZZzPTt2KTXs14OOkW+bF1X9528rtXg8n9y0yGfDE
        AT4p5gAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Kzy-0091NL-0x;
        Tue, 23 May 2023 05:55:54 +0000
Date:   Mon, 22 May 2023 22:55:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Song Liu <song@kernel.org>, Christoph Hellwig <hch@infradead.org>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] md/raid5: Convert stripe_head's "dev" to flexible
 array member
Message-ID: <ZGxVatFgD1u1x+5c@infradead.org>
References: <20230522212114.gonna.589-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522212114.gonna.589-kees@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 02:21:15PM -0700, Kees Cook wrote:
> -	} dev[1]; /* allocated with extra space depending of RAID geometry */
> +	} dev[]; /* allocated with extra space depending of RAID geometry */

I still think this should be:

	/* allocated depending of RAID geometry */

now or dropped entirely, as the extra only made sense when it always
had that magic one.

The actual code changes looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
