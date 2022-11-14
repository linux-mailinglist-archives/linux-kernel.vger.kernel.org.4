Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5453462758E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiKNF3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:29:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E26212D0E;
        Sun, 13 Nov 2022 21:29:49 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j16so17521521lfe.12;
        Sun, 13 Nov 2022 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShWkmDDgnIz8JEqHGHDUzJovR/KTvgrYk+MdmxwWEAI=;
        b=M6oFjAb9H7upWMZ1gY9NJ/kc+g+erCu4WoGXXCT5lXPWnl/RXxHPBTyV1KLUAIHk/A
         Rh1Uu5LoghwGvCVeRw6EUkrnlIddm8KAzSiHZmjCvXNysfvrnd0qW6TX1wnYEj0+Ntg1
         dMdGYWp12oCxRSDO9/tGsx7Ss9JIR5Ot2vM5zHDsYGR5kuiTHiJGcThUFil0RkgluNJe
         T6KHP0I9HC28qUedf9RlDsPxpzClAF20mdHbH+PTwn8hzN+CgKep+SNR+WgTHUhlvM2t
         AB/NU2n/Gd7pApevS+qZtZM+UtC6drf1StNYHKztiToLi01hC8obboH3EOyekflc0NxH
         FHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShWkmDDgnIz8JEqHGHDUzJovR/KTvgrYk+MdmxwWEAI=;
        b=nqmOyZuXaXyF7RINPXnXWZyN0x8diKZp0aPDRzJGjo6rJxBRQ9iCfG+rcXCSRSEs4H
         a3HsahI+neRz2sFoDASETXT60a/rffRy8MedL12/JHHcQ+m4Z6f629iShhMzUZn65J5u
         /Y/pCEUCGUueg2HB9lX5Fakr1q/dapYBcQcHzfdSGDLwI7NVc1HBgOEBha5g6o/me9CL
         TWlvl/Fk1MesE2Yn+1EH9Q2kUYEr8TQGvEwrxn/udr8Uc8Zh2Ye1yC7nIQyDFsboSU7W
         70+LIP1nZd82jWi7bokmhcC8Vw3ySmksre9Utd3mOkZhtCLqRtacPZacyUJxSlCBTsc1
         Fzsg==
X-Gm-Message-State: ANoB5pm/yF4kAK6W73ycWJzuw60H9Cy5t1kjeRGkjWTwNP2D6zLkml+0
        JG3snTB+HXSDkrkAzMgPo9A=
X-Google-Smtp-Source: AA0mqf5TWJtZdRvaHwV/5KDeT3EQPkceXrM7vRnjgc+TPA5daxKBhc5Fe7Yu+19sY5q2HEPVall2CA==
X-Received: by 2002:a05:6512:3b0c:b0:4a0:13b:6618 with SMTP id f12-20020a0565123b0c00b004a0013b6618mr3442388lfv.15.1668403787592;
        Sun, 13 Nov 2022 21:29:47 -0800 (PST)
Received: from thinkpad-p72 ([78.133.163.249])
        by smtp.gmail.com with ESMTPSA id p7-20020a2eb107000000b0026de0c8098csm1853693ljl.26.2022.11.13.21.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 21:29:47 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
Date:   Mon, 14 Nov 2022 06:29:44 +0100
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] udmabuf: add vmap method to udmabuf_ops
Message-ID: <20221114052944.GA7264@thinkpad-p72>
References: <20221113150511.8878-1-lukasz.wiecaszek@gmail.com>
 <50cece73-a499-eba3-7018-9e92e0791c88@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cece73-a499-eba3-7018-9e92e0791c88@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 07:35:20PM +0300, Dmitry Osipenko wrote:
> On 11/13/22 18:05, Lukasz Wiecaszek wrote:
> > +static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> > +{
> > +	struct udmabuf *ubuf = buf->priv;
> > +
> > +	if (!ubuf->vaddr) {
> > +		ubuf->vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
> > +		if (!ubuf->vaddr)
> > +			return -EINVAL;
> > +	}
> 
> Create a new mapping on each vmap_udmabuf() and add the corresponding
> vunmap.
> 
> Otherwise persistent vmapping shall be released together with udmabuf.
> It doesn't look that persistent vmapping is needed for udmabufs.
> 
> -- 
> Best regards,
> Dmitry

Right. Thanks for review and remarks. Adding vunmap sounds reasonable to
me. Will add it somehow this week.

Regards,
Lukasz

