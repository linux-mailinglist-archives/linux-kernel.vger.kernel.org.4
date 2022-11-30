Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A453D63DA49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiK3QNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiK3QNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:13:05 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B56275F5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:13:04 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w129so17251543pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXc9E19NLpLbqbTZEQd+LK0crpatQ7yKh1v7rYDiKl4=;
        b=B6OKjmtzupJjHgJU+ArYpScPzd56SxQhXnHbGZ4LwdgOPDyVSEVmHR3t/0VD6yT7Ta
         cn9knyaA+QTidUoNsyxKVHAU7GNlInGphJ9ZMinO6xkuhRRl7a+9vOFQcxbPZVVO4tVq
         jCV41i4c+YkNg3JIWNvQ+3TUMBpJfySEuEWZB2fSSVJFpQ/pU/pyFuKRMZy4GePIp1qW
         bNmFYQCb++Y0jVNqbiOhGasHrwW4xtEBTP9G2VEbZSy5nmtuaXPOMMLXPLcbQX6nWbQi
         rV1crgogsA703A/CZTeEpFBaixnfMIjDCT42JrbY+0dYCAVBgoynfiMkdpiK7A/H2MXc
         Rj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXc9E19NLpLbqbTZEQd+LK0crpatQ7yKh1v7rYDiKl4=;
        b=V86P8I1YAO9oIqtJL0PGMrd9tTHP/UAgELfY/NM94O969qGxYZirZUiU0eWl4Qoy/L
         lag79apZ7737QvJ7IzewRYn9rDGXcWZkKe8PvxVTvOuV//moW6TxlDT1nAs+1cfApjPB
         K8waGIzoIqWMzuAJQCsGe+NRvxl49FEuSMH8FVwP3F6j+Ojj3JkII0Ez0pl3enXCsLNI
         0MyeC5hyk9WyOe3JbFxw6BGrVT1pyhIxi7ZjAeq13Oyh8U3he1Whe0EcJaLJEofUtj42
         I9X7fJMvvFYs7Nh9H7jXXbU/UY/uR6tz9fcEyrODvulTSJsDsPkT/6YiJNR3o8pkTCVc
         lwqw==
X-Gm-Message-State: ANoB5pktVgE61N/irMoCJKKeiVQoLq9RPaMV96t6gpiu3MLHTP1r5zHE
        QF2JdEBWv6QoCiPWdzxSCIb0NVnxMW/O0w==
X-Google-Smtp-Source: AA0mqf7NSJq8nBLNuFCu0ph96tFw6l73NEC5krrdX1SfKSZ7lTjqrNCwO5PzFpNuU1JOS8VvpL/A4Q==
X-Received: by 2002:a62:31c4:0:b0:56e:989d:7410 with SMTP id x187-20020a6231c4000000b0056e989d7410mr43147563pfx.1.1669824783893;
        Wed, 30 Nov 2022 08:13:03 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0057507bbd704sm1601157pfl.5.2022.11.30.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:13:03 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:12:59 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zi Fan Tan <zifantan@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 5.10 0/6] binder: backports for data leak and UAF
Message-ID: <Y4eBC2Og8VZOSrK8@google.com>
References: <20221130035805.1823970-1-cmllamas@google.com>
 <Y4dPrxKjnUOtvwIc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4dPrxKjnUOtvwIc@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:42:23PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 30, 2022 at 03:57:59AM +0000, Carlos Llamas wrote:
> > This series of backports consists of 3 main patches from Todd submitted
> > upstream in [1]. The intention is to avoid untranslated data from the
> > senders to be visible to the target processes. More details of this
> > issue can be found in the same thread.
> > 
> > Furthermore, Todd's patches also fix a use-after-free issue introduced
> > by commit 32e9f56a96d8 ("binder: don't detect sender/target during
> > buffer cleanup"). In which invalid userspace input causes unprocessed
> > objects to be incorrectly released. Any subsequent references to these
> > objects will trigger a UAF as noted by the following KASAN trace:
> > 
> >  [  244.748468] ==================================================================
> >  [  244.750486] BUG: KASAN: use-after-free in binder_ioctl+0xb88/0x32e0
> >  [  244.751276] Read of size 8 at addr ffff67b1865bea58 by task poc/593
> >  [  244.752074] 
> >  [  244.752725] CPU: 0 PID: 593 Comm: poc Not tainted 5.10.156 #1
> >  [  244.753683] Hardware name: linux,dummy-virt (DT)
> >  [  244.754717] Call trace:
> >  [  244.755216]  dump_backtrace+0x0/0x2a0
> >  [  244.755836]  show_stack+0x18/0x2c
> >  [  244.756306]  dump_stack+0xf8/0x164
> >  [  244.756807]  print_address_description.constprop.0+0x9c/0x538
> >  [  244.757590]  kasan_report+0x120/0x200
> >  [  244.758236]  __asan_load8+0xa0/0xc4
> >  [  244.758756]  binder_ioctl+0xb88/0x32e0
> >  [  244.759283]  __arm64_sys_ioctl+0xd4/0x120
> >  [  244.759677]  el0_svc_common.constprop.0+0xac/0x270
> >  [  244.760184]  do_el0_svc+0x38/0xa0
> >  [  244.760540]  el0_svc+0x1c/0x2c
> >  [  244.760898]  el0_sync_handler+0xe8/0x114
> >  [  244.761419]  el0_sync+0x180/0x1c0
> > 
> > This second issue along with the reference to the commit fixing it was
> > first reported by Zi Fan.
> > 
> > The other 3 commits included in this series are simply upstream fixes
> > for the main patches.
> > 
> > I've tested this series applied to 5.10 and 5.4 which fixes the issues
> > above as expected. So please pick these up for 5.10 and 5.4 stable.
> > 
> > [1] https://lore.kernel.org/all/20211130185152.437403-1-tkjos@google.com/
> > 
> > Thanks,
> > Carlos Llamas
> > 
> > Cc: Zi Fan Tan <zifantan@google.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> 
> All now queued up, thanks.
> 
> greg k-h

Thanks Greg. Could you also take this series for 5.4? I've also tested
the fixes for that release.

--
Carlos Llamas
