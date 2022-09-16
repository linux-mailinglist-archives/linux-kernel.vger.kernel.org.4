Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752275BAED3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIPOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIPOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:04:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C9AB1A0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:03:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so25801476pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=3OTmyo1mGiZf3mgRMhkIq5B8t/bRaWvcsZUDxYNGD4A=;
        b=TGEinON0Fded7JJVqfGVD7Q/qOeKWkV8DGi5bWLJ3mthsbDuQQ8q6uCwXWAf91mWnl
         v3z5140uvzSc6mdXF2Baw6so5TmYMtA7MgMdw35gagK6Jr+CrjzoaPJhWLBYFLvoK0Jk
         lEbGN0yZnz99b0NjirxwuH9xL9Yg7FhuHXR1QP6K/bBQaiStONMWht+VLE8dueKNCiXO
         pD3gvMlOtfIieYnkvvJEfoTss2NWIaSwbMNAYz65FqrCAaplNYKN5zIVoZOiEczzMHxf
         LGvVuSTASt6AWNpb6vGMbsCDSYj733xJkGzKEb9qd5tAclQP3ZyE92cxnQ086q8WYKS7
         Qyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3OTmyo1mGiZf3mgRMhkIq5B8t/bRaWvcsZUDxYNGD4A=;
        b=YB5j4Lgslhp8NK/pc9g+OEWt2iTjB+grVNfwzG16pMxUWLkox9aR/cx7CF5hgEN3qP
         uc3cRi8jB5FsxHBmMwHFVGPfmp1jORRnaFNOgeXiYEZRAF7c6JBStGjoHP1na4YceUcr
         4Sl70/rHSXq5TcT04oPcSureL42nkQ9XEt9KP74GjKw0bWmPYXcBXr6ppTJL4XR0KxXI
         J4w/PV0+Q22eGB7MV/JpFA/9emrhmw/LgA/6vrzJa6Isk7w9RYi+Tme6BDHcCxr7FsnM
         MdtqWIMa8eSwq54E4eXlk8o/Qw2R+SgiXD1MLiF4a2Xr369Hxi0OUfQfapnSu1nUfQXp
         9xIw==
X-Gm-Message-State: ACrzQf2xTUpAnNobkkjA7UPq4BWzlpWAuZJDtNqts4lmCXXEbi6iaEsk
        RUtTijcq26VusfufdED8Y4k=
X-Google-Smtp-Source: AMsMyM4XuEI0vhu5Nb9fu3ZnB1EKYwamXS5oYBSxEyx/lHPF5HC4b/t4CR+N/4trHM3EkZDbfy00PQ==
X-Received: by 2002:a17:90b:1bd2:b0:202:56b2:4f35 with SMTP id oa18-20020a17090b1bd200b0020256b24f35mr16343239pjb.65.1663337038235;
        Fri, 16 Sep 2022 07:03:58 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001743be790b4sm14868872pls.215.2022.09.16.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:03:57 -0700 (PDT)
Date:   Fri, 16 Sep 2022 07:03:53 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, imv4bel@gmail.com
Subject: Re: [PATCH v3] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
Message-ID: <20220916140353.GA235538@ubuntu>
References: <20220916134751.GA234676@ubuntu>
 <21d84319-4d1a-8d8e-a098-947772406faf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21d84319-4d1a-8d8e-a098-947772406faf@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 04:54:11PM +0300, Ilpo Järvinen wrote:
> On Fri, 16 Sep 2022, Hyunwoo Kim wrote:
> 
> > A race condition may occur if the user physically removes
> > the pcmcia device while calling ioctl() for this tty device node.
> > 
> > This is a race condition between the mgslpc_ioctl() function and
> > the mgslpc_detach() function, which may eventually result in UAF.
> > 
> > So, add a refcount check to mgslpc_detach() to free the structure
> > after the tty device node is close()d.
> > 
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> > @@ -2517,9 +2548,14 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
> >  	if (debug_level >= DEBUG_LEVEL_INFO)
> >  		printk("%s(%d):mgslpc_open(%s) success\n",
> >  			 __FILE__, __LINE__, info->device_name);
> > +
> > +	kref_get(&info->refcnt);
> >  	retval = 0;
> > +	mutex_unlock(&remove_mutex);
> >  
> > +	return retval;
> >  cleanup:
> > +	mutex_unlock(&remove_mutex);
> >  	return retval;
> 
> Just move the cleanup label instead.

I'm sorry, but could you please explain a bit more?


Best Regards,
Hyunwoo Kim.
