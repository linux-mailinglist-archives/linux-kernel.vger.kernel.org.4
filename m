Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB31660C9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiJYKPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiJYKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:15:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5A28E15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:09:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pb15so10290452pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCXw0UA96QeHEH8Gn+ovmoUklNS1kt2A9otcWEOya8E=;
        b=Om9YwnZn5/Ox6/NEgIaV/MkxeXIrNsIXzsgH2zsNBbtRj/g3NCm7r3EbxMco3j3Qox
         PUjMTrXQKgpFr5HLTHI4EzJ+lwrO8R4AuGtMgxKjM6UQG+cWS5df5WuS7XCoVQVnmS9V
         2sOU6CJY3UQOkJDPNGPrpP7bOFDRKAJxeAltk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCXw0UA96QeHEH8Gn+ovmoUklNS1kt2A9otcWEOya8E=;
        b=BIFX8y7Ng+Wq2EqZAu6IWRKlKk1i2YLllOxN+3bCCF/eE/HdwGnB0gnskwV+vHyaD0
         cf/MdvW+t1JH2dMNfe5jdIkuoSm54hJMDFz3KHBL+aXU72A+fEZVGB66+ool2K5KOH2v
         rzT/l3omMwYqADDJKS30X3obqj3cjKYj18+RjyhRqle+uBhMriosR6qA9KN0Vkx/G+AV
         9JbwuGKtKtBLg9Zqu+qCsMPrKObhg2YLrUhKM7BPkkVMA/wFq8jPY95NO1jKC4R1CibI
         tlC7uYo5O8nAU3SuYN6lBvYzhL/wEx/WVKRKzlSEa1ka8lNaqaZolxiTfDr+bKVcqhrT
         bjtg==
X-Gm-Message-State: ACrzQf2I+wdx3BdJ62xvz+0jqd61cERBps/koXlKch7XurKXM2iJaBTh
        GZqF6hb9Rje/VWDdqKCwSePvHw==
X-Google-Smtp-Source: AMsMyM4Qy0hAPj+Q1q2v0pY8SWjRzQ9f25STkDSZv2GGC0fOFB5bveXkGuIX/RzAQNJmeqqCBjla2A==
X-Received: by 2002:a17:903:41cf:b0:186:ac4b:21b7 with SMTP id u15-20020a17090341cf00b00186ac4b21b7mr8808238ple.123.1666692540176;
        Tue, 25 Oct 2022 03:09:00 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id i23-20020a63e917000000b00456891e1dacsm966165pgh.68.2022.10.25.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 03:08:58 -0700 (PDT)
Date:   Tue, 25 Oct 2022 19:08:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Aleksey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Message-ID: <Y1e1tvMMXU5+8JQP@google.com>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com>
 <Y1dEOLjD+kpdz0Vo@google.com>
 <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 09:49), Aleksey Romanov wrote:
> On Tue, Oct 25, 2022 at 11:04:40AM +0900, Sergey Senozhatsky wrote:
> > On (22/10/25 10:53), Sergey Senozhatsky wrote:
> > > > +unsigned int zs_get_class_size(struct zs_pool *pool, unsigned int size)
> > > > +{
> > > > +	struct size_class *class = pool->size_class[get_size_class_index(size)];
> > > > +
> > > > +	return class->size;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(zs_get_class_size);

I wonder if we want to return class->index instead of class->size?

Something like this (a sketch)

  Return: the index of the zsmalloc &size_class that hold objects of the
  provided size.

unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
{
        struct size_class *class = pool->size_class[get_size_class_index(size)];

        return class->index;
}
