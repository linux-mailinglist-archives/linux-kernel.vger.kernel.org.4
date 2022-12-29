Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E00658D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiL2NSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiL2NSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:18:35 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD34910055
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:18:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q68so4875867pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FkDYRJyHc7HQuCjR7Lw84B52eC6eGMfJnmRmGgtC/WE=;
        b=ltaLH/n843UzB00wrBZnuJufjLmGpY4njvvLEKYGysy3VDNwdbPERXR87PIv0IGvRj
         3M2BzUAv3HK5EzPB2RgZd86tZhiXfLbT5C7uoH6QFAxWEdBt6UaQkJFazBensnVm1FLl
         v4kak17RY0xhw/TbTiwn3mjcToQXiev9WVLvs58LdoAOl1YVqjKMvW37GTOteymDhK06
         SjrBUCFwmEtHpDgBaFhlmipxgP4So7DT6hlClgGseowSihZZg8pJJhrK45zRFYKRcziE
         YDEdEfXUNPelMJ29QBNG8kqnFYlXVQ/qsc4Lf9YcgKnMW6cz7iiu9EFWNnIdQlSPv/sC
         HYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkDYRJyHc7HQuCjR7Lw84B52eC6eGMfJnmRmGgtC/WE=;
        b=SYpgzP6beHqRiDSB4sF+cj1U5eWTwAFvVzTJhQurzYvLbsyRiFYUgRgr8jb8AVOxJI
         ra0fvraWuM1xNO62tRT6rOEyqPe1W6Y0uLupdX+mlk1wVyKvTuBrpMSs2tB0ifz/91i1
         e0aA26O5vX/jgh/L0DTT0Us5SM0six75lwzIp91SA0Ye7TorIHGPa88RetF9tJDj/0Vg
         OtNAIxnYNugmobWFYId6cnJItsuiuiUj4GkvhpSSo16W5+Dpvm1a8Z6pFnWj7vbStLdT
         bbgBfH21xcI27y20XOoY55zEG4aTqcDxz9tyuc/n/LnNJxKaQoDT1x8h5oPyDwhHCEaF
         GP7w==
X-Gm-Message-State: AFqh2koEJ6Rn8x36OM3V6TGa4HyqbsQThWH5iqYzvV6O5Cfew8JySiqT
        7X56o/y4lyKV7aznLfV3R6A8/XxE/Trl4g==
X-Google-Smtp-Source: AMrXdXtjr33uVQb2dVNIAL67+xwclD9EjNgraufmUA0Konf/6RnnTHRU59fb4AiDYGSBlceo2Fc/Iw==
X-Received: by 2002:a05:6a00:1d09:b0:581:254d:caa0 with SMTP id a9-20020a056a001d0900b00581254dcaa0mr14400452pfx.6.1672319914249;
        Thu, 29 Dec 2022 05:18:34 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e62-20020a621e41000000b005810c4286d6sm7580772pfe.0.2022.12.29.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:18:33 -0800 (PST)
Date:   Thu, 29 Dec 2022 22:18:27 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 1/4] mm/hwpoison: remove MF_MSG_SLAB from
 action_page_types
Message-ID: <Y62To7OcVSScl3p9@hyeyoo>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-2-42.hyeyoo@gmail.com>
 <20221220235246.GA2334024@hori.linux.bs1.fc.nec.co.jp>
 <Y6M7wJu6ikxu+zkB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6M7wJu6ikxu+zkB@smile.fi.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 07:00:48PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 20, 2022 at 11:53:11PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Sun, Dec 18, 2022 at 07:18:58PM +0900, Hyeonggon Yoo wrote:
> > > As suggested by Naoya [1], identify_page_state() is never
> > > called when handling memory error on a slab page.
> > > 
> > > Clean this up before moving PG_slab flag to page_type in later patch.
> 
> > > [1] https://lore.kernel.org/linux-mm/Y2s+dnBsHAJu19ob@hyeyoo/#r
> 
> You can make it to be a Link: tag.

Will do in next version, thanks!

-- 
Thanks,
Hyeonggon
