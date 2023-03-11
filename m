Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB26B58A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCKFhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCKFhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:37:21 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12667128015
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:37:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id x34so7318225pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678513038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnolAekGLDWRGlpmlkuW39BEHuhFi41L/amAT0YRfyw=;
        b=kD2iJ4RItm1hDE2qqnhZNx2dBcP/CFtY3z69ujYEOZvQq6cG/56vO5Z/SByJj6BREe
         E0tEgtFmLzLkudQz2ixvHSbBaTblYb2JdDbcBvRwoW73V4wI5fMnA22ONWCsbafdn9bN
         ZMT2SzPLpY5E+z63+iJzbenE/D4PPrX/1QjNpzYtIj3FgIkuyB/jQBqEYGanSO4pM9D/
         p7T6txd4njKMqfIpuUyLH1NhTwh1pEBMbg2AGrxEiXtdGsMN5Br8c3z9ieFSkEor2aWO
         O8JS/VY04XGW+6k/2VQWsiIovCyJ3ix+NXRR+2nNroKpMhTA68ypdiSYCk5SlaiL0hgE
         yZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678513038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnolAekGLDWRGlpmlkuW39BEHuhFi41L/amAT0YRfyw=;
        b=mXGwb/h415ICxwlDp3BVEhEFwBa5nx19kwJ9t1t48BStJy07lXZ4DeFiCMaETMks9K
         p5b9hNlHTqoafwD/6SRjXN1MQ0QrnkaGo1RQaoHtnZpRtm6FZZrWEH0M2OfkpRmX8FxW
         TFkdrnz7KYd9WmhozzPbSPh3ptATuf/NpBcGLO8vKXFaSYhPm4Guk7KK19S7J+Nvftic
         1bWcf6sy37k4d2JQAKaRtI+Gxr2VcZtvUdfT3osFU96cytzDw58lCnsqP8wsObdjnAjI
         LbUuIzgAXP09bun4Nq2xgEUxPwc4tBFlQGPTP31aMEPPa++cxOAQofvTJL0Sai1Axz4i
         ZjEQ==
X-Gm-Message-State: AO0yUKWsFkvlsvcQOP2I4wXfFTPwXQjd7iYySn3MKuLWjmrcdNuJvMDm
        Uxpg89aNnw8F6bGpKzBmbgk=
X-Google-Smtp-Source: AK7set+iMslHMppwB36bFbWIWMet6sxjM6XD0aolUg7vy5ZigQS42wRYAGVdU1Z1FQTe/XX177Iqjg==
X-Received: by 2002:a17:903:1d1:b0:19e:608d:6844 with SMTP id e17-20020a17090301d100b0019e608d6844mr35997626plh.10.1678513038561;
        Fri, 10 Mar 2023 21:37:18 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id kb4-20020a170903338400b00194d14d8e54sm839958plb.96.2023.03.10.21.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 21:37:18 -0800 (PST)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v5 2/6] ksm: support unsharing zero pages placed by KSM
Date:   Sat, 11 Mar 2023 05:37:14 +0000
Message-Id: <20230311053714.178439-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <david@redhat.com>
References: <david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry to reply so late, on vacation too, and my mailing system has some kind of problem]

>[sorry, was on vacation last week]

>> Why use flags if they both conditions are mutually exclusive?
> 
> Just to make the return value of break_ksm_pmd_entry() more expressive and
> understandable. because break_ksm_pmd_entry have three types of returned
> values (0, 1, 2).

> It adds confusion. Just simplify it please.

So I think it's good to add a enum value of 0 listed here as suggested
by Claudio Imbrenda.

> 
>> MADV_UNMERGEABLE -> unmerge_ksm_pages() will never unshare the shared
>> zeropage? I thought the patch description mentions that that is one of
>> the goals?
> 
> No, MADV_UNMERGEABLE will trigger KSM to unshare the shared zeropages in the
> context of "get_next_rmap_item() -> unshare_zero_pages(), but not directly in the
> context of " madvise()-> unmerge_ksm_pages() ". The reason for this is to avoid
> increasing long delays of madvise() calling on unsharing zero pages.
> 

>Why do we care and make this case special?

Yeah, the code seems a bit special, but it is a helpless way and best choice, because the
action of unsharing zero-pages is too complex and CPU consuming because checking whether the
page we get is actually placed by KSM or not is not a easy thing in the context of
unmerge_ksm_pages.

In experiment, unsharing zero-pages in the context of unmerge_ksm_pages cause user' madvise()
spend 5 times the time than the way of the current patch.

So let's leave it as it is now. I will add a (short) explanation of when and why the new
unshare_zero_page flag should be used.

Sincerely.
Xu Xin
