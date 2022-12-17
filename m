Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656164F885
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 10:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiLQJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 04:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 04:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EAFE0AE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671270388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GntWWxKRpPWeMm1mhv68BBTf942P1DbZlrM3OVZ+Drk=;
        b=Ysgxf8JpRihABLqqX4MN2WXflg11U7b6u4QG9yng9TtCGokQWpT6FW7K2YkL5Ekrnf/iGl
        mTNLjaJDXYfl0A76sNsApapiqRek/nlHuMKJoYZ3Wwx2uKdIzORjQQG7Y1mJ/LIXoORk5O
        ACf0rZaxYabUzjsx2J81tlAgMXy4VgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-d2W2HETrPLKLL2cPf6ZZsg-1; Sat, 17 Dec 2022 04:46:25 -0500
X-MC-Unique: d2W2HETrPLKLL2cPf6ZZsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74CC9101A55E;
        Sat, 17 Dec 2022 09:46:24 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75A2540C2064;
        Sat, 17 Dec 2022 09:46:22 +0000 (UTC)
Date:   Sat, 17 Dec 2022 17:46:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-mm@kvack.org, urezki@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y52P5eQJUVCOSNdI@MiWiFi-R3L-srv>
References: <20221217015435.73889-4-bhe@redhat.com>
 <202212171403.0vwPwJ3y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212171403.0vwPwJ3y-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/22 at 02:41pm, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-vmalloc-c-allow-vread-to-read-out-vm_map_ram-areas/20221217-095615
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20221217015435.73889-4-bhe%40redhat.com
> patch subject: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
> config: loongarch-randconfig-r006-20221216
> compiler: loongarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/368cd65be8fedd1642e53393dc3f28ff8726122d
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-vmalloc-c-allow-vread-to-read-out-vm_map_ram-areas/20221217-095615
>         git checkout 368cd65be8fedd1642e53393dc3f28ff8726122d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/vmalloc.c: In function 'vb_vread':
> >> mm/vmalloc.c:3563:49: warning: suggest parentheses around '-' inside '<<' [-Wparentheses]
>     3563 |                 n = (re - rs + 1) << PAGE_SHIFT - offset;

Thanks, below code change can fix the warning.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bdaceda1b878..ec5665e70114 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3544,7 +3544,7 @@ static void vb_vread(char *buf, char *addr, int count)
 		}
 		/*it could start reading from the middle of used region*/
 		offset = offset_in_page(addr);
-		n = (re - rs + 1) << PAGE_SHIFT - offset;
+		n = ((re - rs + 1) << PAGE_SHIFT) - offset;
 		if (n > count)
 			n = count;
 		aligned_vread(buf, start+offset, n);

