Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4AC5FCBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJLToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJLToL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:44:11 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F3278587;
        Wed, 12 Oct 2022 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SEsOJPccncUf9asxPB8n32Yu7J9QL+U/NyQGwZbIDxY=; b=pwO2ZcxsQ6YRCYHbiroRiyKNKc
        lxZea+9q4J+fpIByQsWxyL9FlyFveWgsASEvhofYKp/WXWzD38fw0PXJjJbt1u0SMcCdH0bhhNqw1
        SixEEKDI4TysV682FECEehB4iTxX4I9n47Gqb9MzZcJcNyPdQnyUVX9rJVg17amhQO1rsegJaQgsm
        4628S+MNW18763YXxsJ37TDHQB/3rdRrl8FKra6qSCEZb6eFNBRK9S47RFNby6k7DKbScfjosSZYr
        yoKtyc+eTWWMFF7zdxdZYVBlBFT2rYLJJYWLEua9jLECwY/YKocyR1W17XDdkC1YrdIuO2yvzefAv
        UCDEHP3Q==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oihe5-000OLe-Oh; Wed, 12 Oct 2022 21:44:02 +0200
Message-ID: <ef4743f3-b1b5-8c94-a800-bcf1463040f9@igalia.com>
Date:   Wed, 12 Oct 2022 16:43:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/5] pstore/ram: Consolidate kfree() paths
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-2-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221011200112.731334-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 17:01, Kees Cook wrote:
> There's no reason to keep separate kfree() paths: either all allocations
> succeeded, or not. Everything is torn down in the case of failure, so
> adjust the callers to reflect this.
> 
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/ram.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Tested by building / booting and triggering crashes with efi and ramoops
backends.
Cheers,


Guilherme
