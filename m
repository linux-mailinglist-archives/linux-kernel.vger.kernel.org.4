Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA82717D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjEaKxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjEaKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:52:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D08188;
        Wed, 31 May 2023 03:52:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso6653783e87.3;
        Wed, 31 May 2023 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685530373; x=1688122373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mF96JxhPOfJm8OwVPyiERGBu/9SGI9YEMVv93ttrAE=;
        b=K7S/m1yN1z3wihwPQ0aqTmA8KTPkPzoE4oY+Og9RwgyPhTsaOBXcjY7r2d300+ffca
         kOLeizWVKQ6nVthj2EPf0aJSFkNGa5KAe4B/un7+eBje/DITcVV0Xd5UdvKMOLqqrGFX
         1nOc6HcrUAFNIgZ4xd7xMUq4iLmwXgB3yDgc3N54GWlOER/f3wHDaTO3QojJ+oI7hTBl
         msvwt1w7DAy76NtRu6/dGzXXgPoXKFpCGf1/PJXnx7Hzen6p/OuP/cavKe1B8J8U5Fzc
         ZK3qKnDWhNH2Jde/ntE9HFFV5CpPfgJ8ohZT/gvfjPORjo6CLoEgR+hffPq2q9Y/lnC9
         hiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685530373; x=1688122373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mF96JxhPOfJm8OwVPyiERGBu/9SGI9YEMVv93ttrAE=;
        b=OQLoEXiDAiGBnKweHT+Ngl/q4Apt7qML3ms8YfeWnhwR4QIPZgfHmao/mSCOXlWA6y
         7LXhA596P5TBgc/OXFU2zZs+yU2xQ5QXBk+Yjh5VwxgYeQDYHrScsJxRogyq/lNYBAHU
         I2KZ8g+SFgDS9uy9LsJ2USVgdO9rjGZSXT7ifeUyUm4oTU4yJ8vBk8kZJ4XDLupvJXD8
         3qDv0TpjOVoeSxoBJewIZSpzJdHi7XCKOMs1X/kxWlRm55f0MByX8KJ8oB/sk2QZQtXx
         RjOTW8orMBTtrdixrgavMLPzzkJvQpk+h36UW3pJzG1vSW3/xCd2p+ZKE/T+JQduNP06
         G1xQ==
X-Gm-Message-State: AC+VfDwaLfc6old6+wXBhGm956uIVJDKMhO3FfiRK5cYgRvmqs9kLmmL
        B8xLLyoGVG3A8Hu8yFYCqljuxgklbLg=
X-Google-Smtp-Source: ACHHUZ5j1XndLfbwk06LhgPRrqGIp7j60e08yFoVMYU25rWfrpw/W8XBPCZ+IWMBtNMWRfXQg7PnYg==
X-Received: by 2002:ac2:5605:0:b0:4f4:ce78:2f17 with SMTP id v5-20020ac25605000000b004f4ce782f17mr2316420lfd.13.1685530372868;
        Wed, 31 May 2023 03:52:52 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id z27-20020ac25dfb000000b004f13cd61ebbsm672102lfq.175.2023.05.31.03.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:52:52 -0700 (PDT)
Date:   Wed, 31 May 2023 13:52:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Osama Muhammad <osmtendev@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi-dw-core.c: Fix error checking for
 debugfs_create_dir
Message-ID: <20230531105250.6pd5jpngwbnbnbbc@mobilestation>
References: <20230520224025.14928-1-osmtendev@gmail.com>
 <168546845148.691057.9965315836245052581.b4-ty@kernel.org>
 <20230530211446.foqpcfha6hjruhow@mobilestation>
 <30bcf77a-3e7c-4f13-94ab-f4efc52193dc@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bcf77a-3e7c-4f13-94ab-f4efc52193dc@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:16:00PM +0100, Mark Brown wrote:
> On Wed, May 31, 2023 at 12:14:46AM +0300, Serge Semin wrote:
> 
> > Oh, thanks. I've absolutely missed the respinned version of the patch
> > (it should have been marked as v2 though). Anyway the change looks
> > good except it introduces a redundant empty line at the tail of the
> > dw_spi_debugfs_init() function. Is it possible to rebase the branch
> > and drop the line it? If it's not I'll send an incremental cleanup
> > patch then.
> 
> I'd rather just take the incremental patch here.

Done. Please find the cleanup patch here:
https://lore.kernel.org/linux-spi/20230530221725.26319-1-Sergey.Semin@baikalelectronics.ru

-Serge(y)

