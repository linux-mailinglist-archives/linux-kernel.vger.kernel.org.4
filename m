Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC42727592
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjFHDUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFHDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:19:58 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83F19A4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:19:54 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230608031952epoutp03fc376ea85b36caa19770ac2ddfd4a118~mkN2lXk8G2806628066epoutp03J
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:19:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230608031952epoutp03fc376ea85b36caa19770ac2ddfd4a118~mkN2lXk8G2806628066epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686194392;
        bh=DJGThkxGj7XgBgn4Eq/sk4HOuPuXpOiAbUO7wgIDrL4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Tc2Ixb6Fo8jhSrVIlWMbFepBpmh6EVxO0D04gfxKbJ5YBHewv2ocIJ7YckcGqMqcV
         0yEBqoKKDOw75XBo9uUg8lrXNWYJVKEncFLwD48zWXXV9dthS3VuWWUzkts6QgeeZS
         15km4swjkRRtz/QQgq04TacH52KsOxUopM2l8Ce8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230608031950epcas5p267aa6739f14a867fcb2c844824af4fce~mkN1OVwOV1188011880epcas5p2a;
        Thu,  8 Jun 2023 03:19:50 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-92-648148d69d10
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.B9.16380.6D841846; Thu,  8 Jun 2023 12:19:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4 2/3] bpf: make bpf_dump_raw_ok() based on
 CONFIG_KALLSYMS
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "vincenzopalazzodev@gmail.com" <vincenzopalazzodev@gmail.com>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "michael.christie@oracle.com" <michael.christie@oracle.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "glider@google.com" <glider@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>,
        "alan.maguire@oracle.com" <alan.maguire@oracle.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Onkarnath <onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAEf4Bzb4B9FxMnf3t81D22FWkciLOvwDPLY0BbEPGGe7R5QPrg@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230608031011epcms5p23c6aa244e514729b98df2af7e45db67c@epcms5p2>
Date:   Thu, 08 Jun 2023 08:40:11 +0530
X-CMS-MailID: 20230608031011epcms5p23c6aa244e514729b98df2af7e45db67c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxTVxzNfV99ELs9CwtX+RCbGIXEFje23cw52STZyxZdddNtJM417Rsg
        FLpWPpybUGA2IDiVoV1L5EOUWmB1FAYrYhGrlYmLYNQC2UZGCS6kri06Rey6ldK4/07O79xz
        fueXS+OCM9RKOjtvH6fKk+YKqUjix8tJSevvsBp5irM9ATkHNQSytZ0k0aMFA44ezE/wUHuX
        BkNzdgeFZi/7ADrd9DeOtN5+HA06bDxUP/YiKus1Ysj+rR5Hw4cVaOZiDYZuWesp1F55jkTO
        o9MA+Y87SXSuoRUgY7WHRI6aAQwFph6S6IzRTaLRx7MEcrT6KeS3X8KQ64mPQkdu7ED3WnQg
        LYE1lI4Q7LHy+zz2J/2vPLaxs4CtsLtJ1mJMZqucozjbaaqk2KbSOpz1To8T7JEuE2DNXbcJ
        dq4zQcLPiHxdzuVmF3Iq8RufRmbNjJsJpY0srj1eRpWCH4gqEEFDJhU2D0yQVSCSFjB9AC5Y
        3P8NaJrPLIf+3qigJorZAReu6bEgFjCr4U1dOwhKopgU+KR7XZCmGBE0WS8sWkYzYmj5xkcE
        LXFmIhJ2mL6jQll8qNNOL+XGwp7WbhDEEcx2WFXpIUP8C3Cszc0L47+uNoAQjoZf/3YDD+Hl
        cHK+b4mPg22WmiXPA3B69hcqGAyZCgAv9oVFr0Jzi2nRlM9shf1TDxYfEMwaeKL2ChksA5l0
        6BvaFaRxZhXscdfjQRpnkqDZKg65xMO6n7/HQpLnYM2CCwvX6j0Vxmtgxdh5MlxxzutdWo2F
        /pkLvNCZD+PwtLUVPwoS9c8urf9fsv5ZciPATWAFp1QrMjn1y8qX8rgikVqqUBfkZYpk+YpO
        sPiTk9/tBX9MekSDAKPBIIA0Lozm791cIhfw5dL9X3Cq/D2qglxOPQhiaUIYw1+7aUgmYDKl
        +7gcjlNyqvAUoyNWlmJJLvbKmzHjH++aG9oqfT+1WxedhuwWSl+4TfRWccaJUxPSW+Lq9YH4
        tuzEuNTduozPltlWvKIpMZhG3RS1UWvWLtBbBMUy/gcHEhXV6vM7hQNFnw9pLMPWp+u+vHSf
        fzXeoy3LSc7JCzz8pOFgnOGY40PJiGFbQFDrup5TPvWeqMRT/rzvbH385uuS2cLJr0Zv6q39
        aVtA0dz+O8qnWkmTd+eeefleniKqg4t1zU92tCgb08tv330ty+jP7zGRu5HYWpLxWO9X/nP3
        rKtW98jfVRCbL3vHtqE5Zvjt9GW2onur68Z8HxWPXPt9OGVVwLKpTXbo4EbtyUOK5j89ZkmZ
        kFBnSTck4yq19F8TRlEjOAQAAA==
X-CMS-RootMailID: 20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a
References: <CAEf4Bzb4B9FxMnf3t81D22FWkciLOvwDPLY0BbEPGGe7R5QPrg@mail.gmail.com>
        <20230606042802.508954-1-maninder1.s@samsung.com>
        <20230606042802.508954-2-maninder1.s@samsung.com>
        <CAEf4BzYavyL431eA_HZ-X8+wTeO4Cyt7tGDUbPB0yqPru=ZUSw@mail.gmail.com>
        <20230607034028epcms5p8ed013806c42bd79b76368ac015a7b6ba@epcms5p8>
        <CGME20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a@epcms5p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > also as per below code:
> > (we were not sure whether BPF will work or not with patch 3/3 because of no expertise on BPF code,
> > so we keep the behaviour same)
> 
> I think bpf_dump_raw_ok() is purely about checking whether it's ok to
> return unobfuscated kernel addresses to user/BPF program. So it feels
> like it should be ok to just rely on kallsyms_show_value() and not
> special case here. If some of the code relies on actually having
> CONFIG_KALLSYMS and related functionality, it should be properly
> guarded already (or should enforce `SELECT KALLSYMS` in Kconfig).

Thanks for your confirmation, I will resend patches without bpf change.

Thanks,
Maninder Singh
