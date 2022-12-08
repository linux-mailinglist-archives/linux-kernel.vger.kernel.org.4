Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82646473CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLHQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLHQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:02:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB139B28E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:02:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vv4so5142434ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgTcP7Sb6G+mxt6RrmX5diGBUpEOwhypZwyQEkEjZUo=;
        b=KLiZD2qBOu/qNsJ2cZjRu0xhRjkjzMUvesjTwJF+Nj34blnUwi+EXBP1laZJLS8qQj
         cAr+pVGQEkgP7EGIXfq2cAWyFCTDfhDG4cfZCYyiuGXVclg4Ynx/DWUMEaRSTGz833dN
         NCoHV26jGRcTcQFsYg2jyVoKA97rHaaFhk9n7HsPuWB/Tb8YKl8MTuMkV3zveMStl4JV
         Fs1Hau6UHdvfP1TGdyZ2wg9UWxVTI+u/sCEEHMSHyEXMjnoVcHwKffCOiWvuQNiEBOqL
         qxXGyjwsH7GGufZlywGdDJo7ICy0YGaGpAj92BiZSrgKRLKt3z8huikoi8IE9RYGETD6
         s8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgTcP7Sb6G+mxt6RrmX5diGBUpEOwhypZwyQEkEjZUo=;
        b=CNtcInEeFmxg+myVaXv2vYFGfGb1jYCXJ1b9uhN/XZva0hIcgSRT5lpAQfcddqnl49
         8XUZN3ASUQrB+20G2bh7IxvYbun7yzHgDhHWaSU2/+mgjO4bYvtyhsX7XFY08OlWqrJZ
         nCc5hXf/5Fa3VcRovgUXHbFDyIc13VUyUm9julsTz/vOzJzRB5WMEN8sF2qmxZXGBfiz
         ErR/kiabBycaZ2J3JerydtP/ZI2B1lkrmqU4t4Tzf76SMXyqJls6noNmd4TQ4CQrRPJb
         Z/a21W/WJ+Sryatkxb4QRpriz5/Tswutwn4TB9ZC6v3Vw3DgRksL57wWdOvcJTvKWsbg
         ZIZA==
X-Gm-Message-State: ANoB5pk5hW5eMp9S7rcefgjTbX0u3nT4pD2r8MNZm1ltG0rMM1pUC9+r
        BYoNqw8OlJmtnDMoyxYFPOsiqg==
X-Google-Smtp-Source: AA0mqf7BntqxGCpKPwxV6jdJ+uAdbt8+2G6+VAMqcwwJNz/syMYkGpO94/UjsegtDWOy3jZydWHzVQ==
X-Received: by 2002:a17:906:1e4d:b0:7c1:ac8:73a0 with SMTP id i13-20020a1709061e4d00b007c10ac873a0mr2285776ejj.51.1670515330398;
        Thu, 08 Dec 2022 08:02:10 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709060f1000b007c1175334basm2675858eji.78.2022.12.08.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:02:08 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:02:04 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     leon@kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ice: Add check for kzalloc
Message-ID: <Y5IKfOOhinE66+Kt@nanopsycho>
References: <20221208133552.21915-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208133552.21915-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Dec 08, 2022 at 02:35:52PM CET, jiasheng@iscas.ac.cn wrote:
>Add the check for the return value of kzalloc in order to avoid
>NULL pointer dereference.
>Moreover, use the goto-label to share the clean code.
>
>Fixes: d6b98c8d242a ("ice: add write functionality for GNSS TTY")
>Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
