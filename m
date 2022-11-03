Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29689618829
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKCTD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiKCTDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:03:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E1C00
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:03:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f5so7865677ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DioTjweT8KyYTLuW26n5h4+LNZhEhCW5cXTFnLxttEY=;
        b=BAuU3NJkBDICD9fsyBURyNg1/8UysMi6bsznAKVacL+BkqHhsy+3JQJ7bYgq+cDHE2
         wI8e2YkecTUbEL5OrKceDyUwhAj9cDlsfksRweNZs8l0td5kJjrEd/LE6Ya/5kpwKeiK
         F1KEEGKfx/Idoib5mezCyh8xbEczGd0LdpsWptoT7JxGKVOni+clDLoexqcHC9/E5l1i
         TYY0RAV//44Igr3ncKSVudBnV7AbNMd39ZzcLUcoxF/UjXCDBblG8CdykN3mzeXJtnFQ
         5X+2dxX4nH+irsLJJ8fOrMdDHqgDfwdDmff3CamGprvcxIl1Sufy2ozUEG+dpT9vhWDk
         1osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DioTjweT8KyYTLuW26n5h4+LNZhEhCW5cXTFnLxttEY=;
        b=pEj7k+nsDc3OqjOexl/sybnzryQbbBOV1EeDRWZRs5yDWVorOgvcUXNfu03gH/MwYP
         /Hzei0EhMSuLpRwKU/XWzjmpvERjp87wjIXw45uHMNeo+tMT/Q5VbN07QfyvCjqEWQWi
         Zn/3NmNNHlvIyQqOt8mfZ4w+O1XV0z9HCI4VRtD88Kt9ewDdpjG8vM7injT2dNBq5L6o
         v8h8+cJfpcK+XPWb22mtcgaiqrRiEyRUmEg+05d3VlrrO0G5yasAkn+juqke72KBODZ0
         XZSQJH0wc3tAcPc7aNXjb/aALtev5WecWmj7kJf6oQgjvWPoPsY1Kx5aMlwO3KSWFF9v
         HCZg==
X-Gm-Message-State: ACrzQf3EpZX+cDAGDmRLxQf4XoY/fBKnDJnZAhFV0ZC5Kk0wEaI1mPns
        v+NH2enP/Pbjj/AOqk4Yhq4bV4fEarGCmfrAfojrHcPo5RM=
X-Google-Smtp-Source: AMsMyM5cWyI1g1xFCpgUIvT+w90lBJOJkECtWNbUCEzN+yIUCwI+UpyahE7TD3txNQP2YmNJ4RWupB5+DM6parrk8Ww=
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id
 dd7-20020a1709069b8700b0073317952855mr30849226ejc.156.1667502230689; Thu, 03
 Nov 2022 12:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221102151836.1310509-1-dionnaglaze@google.com> <CAMkAt6pRVnx3vHkeBeJuf5kHgTF+c3Ydir+r9MRCPMAXic5eog@mail.gmail.com>
In-Reply-To: <CAMkAt6pRVnx3vHkeBeJuf5kHgTF+c3Ydir+r9MRCPMAXic5eog@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 3 Nov 2022 12:03:39 -0700
Message-ID: <CAAH4kHaPzwKsyV7XuKEDS6Q7WsC0+mNz4hsp=MW9n1Pc3=KtrA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add throttling detection to sev-guest
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

> Should this change be rebased on top of the 'virt: sev: Prevent IV
> reuse in SNP guest driver'?
> https://lore.kernel.org/lkml/20221103152318.88354-1-pgonda@google.com/
>
> Since that change is a security fix?

I can do that when your patch gets its Reviewed-By tags.


--
-Dionna Glaze, PhD (she/her)
