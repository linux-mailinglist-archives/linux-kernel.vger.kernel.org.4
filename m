Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC8658D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiL2NjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiL2Ni1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:38:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B414D36
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:36:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so19193521pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLcd8CiyLYIlvCRq1660gY/l+h/v8zU2lfmkPPHTSdQ=;
        b=DZ4mL9PWqEgn4n3LYbFe8pA/69bpQ95H0RcO+2+3yq4x0SDTKvnduhg67Plac3jB1l
         4xNZgV135z+HodeqouoXU1um1hMg6Ht4VF3h9BF3M+VGRViTTRDTgCdp7AN8Yy+QL9vN
         Ct5Eq0YBS2OjbzgkhOheLEOwEIhcN45ExNXkHQD9ALc9mPkJ+n2RnTbjA3XTN2qIml+X
         x7b/enqqiIUwB4qETNRqPfgoBJHWsRxplVg9hU/Od5tRUMZmBw//kaAkhsFcb2VZJaZ+
         G1hdb0CoNsyXKhBxHYzuMnf3q5dqseWxv1LRGFD17x09d90h+AMuNvEUtxRN2K6nskg2
         4nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLcd8CiyLYIlvCRq1660gY/l+h/v8zU2lfmkPPHTSdQ=;
        b=Nt6kYidjIWYHrUHOpLCs8W3OxOvy5bKjS2sFiVfcfJfGlR52CZ6TJZU3/lSAsWg1Ow
         A83CheBtuXYc01rXZK+JNSNcSwaXeX7He4mb1wjzscNscxWrHbV1bjvjLuD7zV718Nwj
         POrDeVuTmNhEXVHAtJbjDQs1K0wF0E56alNxbhLck7/xSL3csyNWZoJ5xTVbtX11KWv/
         v55DsBFs7Um8mTKmaOWWU+M+r6qBoCEA3Q6wtX5WAjiyogawxxEZAWstbPqdBNszhey4
         gJbPT+8R2lOi04Y9RIT1OxgxEmH+IJpirWsjpGg/xnbd80WAaHMQWj/Gnj61OKh7hM5K
         kTeg==
X-Gm-Message-State: AFqh2kr4Wdwcb/AAltoYIcr+8jdYUTDi5KiDsnXuNpyLCyha8VAY7pgV
        pbr+bxZ1nMuyb/knj3u8DsE=
X-Google-Smtp-Source: AMrXdXuaF2hKa0CKPGYmhiCk8cIr5uNdjSWMYoXwWFt8y4Cco8mStUDpXzudgxQ/f9QRGK5XpnVy2w==
X-Received: by 2002:a17:902:ebc9:b0:189:a6be:85db with SMTP id p9-20020a170902ebc900b00189a6be85dbmr33011377plg.39.1672320944404;
        Thu, 29 Dec 2022 05:35:44 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm13002488plg.46.2022.12.29.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:35:43 -0800 (PST)
Date:   Thu, 29 Dec 2022 22:35:37 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y62XqcQUyaeqTQXu@hyeyoo>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-4-42.hyeyoo@gmail.com>
 <Y6AycLbpjVzXM5I9@smile.fi.intel.com>
 <82feabee-0446-b913-adbb-0e96ecb10c94@infradead.org>
 <Y6GVbeB8Onzlcb8c@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GVbeB8Onzlcb8c@smile.fi.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:58:53PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 11:35:38AM -0800, Randy Dunlap wrote:
> > On 12/19/22 01:44, Andy Shevchenko wrote:
> > > On Sun, Dec 18, 2022 at 07:19:00PM +0900, Hyeonggon Yoo wrote:
> 
> ...
> 
> > > #define DEF_PAGETYPE_NAME(_name)	{ PG_##_name, __stringify(_name) }
> > > ...
> > > #undef DEF_PAGETYPE_MASK
> > > 
> > > In this case it decreases the chances of typo in the strings and flags.
> > 
> > I'd say Yes.  (and #undef DEF_PAGETYPE_NAME methinks; or change both to _MASK)
> 
> Ah, it's me who used two different names for the same macro :-)

It seems like a good way to make fewer mistakes.
Will do in next version, thanks! :-)

-- 
Thanks,
Hyeonggon
