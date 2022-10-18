Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A167E60309D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJRQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:18:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785551F2FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c20so18614128ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKbYqOoWF2COe5G8sNkibGFBb96bQI7cBXpi8FW4dE4=;
        b=cRXvqM8+Dzf/G1TotlC+v9y4RKkwI2u9e8XCaUzB6ziEnYmIc046/eJ83fhE7AKPFm
         VEzToU994vgmg7qtYHWW66otfkaNB0iaPmfZWucRv+91I+Au4cXM9jLYh8+2vDyobEbi
         zIHKdvmAnFdqfDu2WyEVQ1HYzLOPof1fWxdW1ffjCX3NOPILJTXiGO0/YkdKggK7FosD
         CrXQqEXI1haMllnYwB+P2zl9MX/KtkRkrwHNxZiwJr17dYoJNoqyDwkVBTSGA8UsWTTk
         Gd9fxyAFVR1uct/s06mlSTtpMrEMUbmmapHyG4OQuwmPSqz/mQFmrGt5cMX4GM4OEQkG
         VDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKbYqOoWF2COe5G8sNkibGFBb96bQI7cBXpi8FW4dE4=;
        b=XdjQ0bhlkFQidJvVLJWhqgkIPI0WKW8ZnsszmPtbukoH0lM+PKBA0FSqFwHR3Vra+H
         Wp6y0lBQ92aulMMJAm0eY2tvw9YRGV+uPRUXZ6i3MESfMklGNNJlgQOJeshQoTlOg5yQ
         S/EJdASizA8ykX8A/THYIXEIKIRDGNgI+AHuBG+A7qsCFURGhSwAIqrdqVvm5oExRc7M
         Y63aN6p5YSB9SgmCaitgqRKaWeiHXXX65hYYg4+rUzxaGylG0OUHyK78dWxBRKoc4gsT
         nRf1M4cRSIp7T9S3NvIHCG5EJMjn0ZNaSwwUe7IrSbCcK+WLZnOC56zQRp5PP8FEsQyw
         jibQ==
X-Gm-Message-State: ACrzQf0/D1UEiU0DwYAZ620Eez3ohdrTeVU6dCNOiDQrjIUm+CRYJMyy
        sCaKZEv0tNlFhw8pPeYtTSg=
X-Google-Smtp-Source: AMsMyM6UP02Lz4ciNc3OAHE6kA9/x5zXeihtn22ryRxH/EuvKmWMQZSf+3A+VWxieAdtH0rO5lrvQA==
X-Received: by 2002:a2e:a887:0:b0:26a:871b:a16d with SMTP id m7-20020a2ea887000000b0026a871ba16dmr1439095ljq.482.1666109879692;
        Tue, 18 Oct 2022 09:17:59 -0700 (PDT)
Received: from pc636 (host-90-235-12-21.mobileonline.telia.com. [90.235.12.21])
        by smtp.gmail.com with ESMTPSA id y13-20020a056512044d00b004a044928923sm1892272lfk.293.2022.10.18.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:17:59 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Oct 2022 18:17:55 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
Message-ID: <Y07Rsz5R1ufZu6Od@pc636>
References: <20221017160233.16582-7-urezki@gmail.com>
 <202210180250.V8hzNH8X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210180250.V8hzNH8X-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Steven.

> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.1-rc1 next-20221017]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc/20221018-000544
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20221017160233.16582-7-urezki%40gmail.com
> patch subject: [PATCH 4/7] mm/vmalloc: Use a trace_alloc_vmap_area event
> config: um-i386_defconfig
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/fbc853c689b29d3bb9fe250b2653fd2dd8046fc7
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc/20221018-000544
>         git checkout fbc853c689b29d3bb9fe250b2653fd2dd8046fc7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/trace/events/vmap.h:123,
>                     from mm/vmalloc.c:47:
> >> include/trace/define_trace.h:84:34: fatal error: trace/events/kernel_vmap.h: No such file or directory
>       84 | # define __TRACE_INCLUDE(system) <trace/events/system.h>
>          |                                  ^
>    compilation terminated.
>
I can reproduce it. It seems it happens so far only on the ARCH=um case.
For regular arm/x86 i do not see such build error.

If i rename the TRACE_SYSTEM macro to something different then "vmap"
it compiles fine. In case of:

#define TRACE_SYSTEM vmap

the prefix "kernel_" is added, thus the header name becomes as kernel_vmap.h

Steven can you give some indications? Or any thoughts about it?

Thank you in advance!

--
Uladzislau Rezki
