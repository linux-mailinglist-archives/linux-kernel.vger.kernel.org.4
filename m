Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46074F9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGKV3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:29:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095DE77
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:29:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1b059dd7c0cso5730857fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689110959; x=1691702959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3g/sYes99jSs40Z6x0waupDib1SvpDaNQo/lAgOIN8=;
        b=NsrhT3+Ll7flWv31+mVfvL2CJi6PPiyztffKniMwPkiIPxd8n1z21jnqQ7T40Vqtos
         y8hPl93hUIm3jjeDUFm18iygCSALICo1EOLi4qgT60kyRSXwnBqYwk+cag3ZUU07zqST
         UpsrongFVzB/JVF8yBLAsnZSWZtYUH6F5x+lysgRhwrEaJ0ahvLOH5WYULISMLXPYugW
         bwcnmLcv6QPeEalrgfKCvRDfAAh9D6Rp+DOH2X0xqtvNxsIldWqGyQC7jxKK5buulsAV
         MarTK5eACf7ZgCiPKgHj/CwzL0KHQXWWrNjTiV+1VRnnNAjYBenPSiXTMjWfdtse4M+n
         azzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689110959; x=1691702959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3g/sYes99jSs40Z6x0waupDib1SvpDaNQo/lAgOIN8=;
        b=EEyv3ZAaoSi3ghYSyJrTwrxCzHidc24e5QYzV+vJJxmmv2cPfkDgxVS8iCzpX7acU3
         4wdD3+KgGjv2RbcCPY9f4C3W4+qatVVZ+07KUpDUya1JgDzhJZ/vzjF/i8pSxKyOPADy
         ZbXNP5yGonRYo91YpdbAo1f/rEXhYDIHB97FGsSBAjNPdGVs3QbLioLFHEW34T4xBi13
         erNpjTpQdinWOk5lwlfeyg8xqFg8OltC2ZtrKD4Dy3ARrtLE+30TcKyAlljoeMaMKQRe
         2EezC2INAh1nZb7941801w8JU+CVG1Bz5YsbPC8LBGx22v8QzqlFEh1kmgLAZSs5fn2q
         C8zQ==
X-Gm-Message-State: ABy/qLboe2WmPnS1cA8HvWfjDOWuXyO0T5AQGkJDlqlh7nDgMs+Z5MRZ
        VoWAYsi9JUdGQDIHBFuh5Aw=
X-Google-Smtp-Source: APBJJlGK0zbcSHw9K20hYnRB8aALJMh64GuD8KNS+gOo8I353uIxeGV3RO9luKO3QrO8ilUxjoILcA==
X-Received: by 2002:a05:6870:c186:b0:1b4:60b3:98c8 with SMTP id h6-20020a056870c18600b001b460b398c8mr16196462oad.1.1689110958733;
        Tue, 11 Jul 2023 14:29:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id n88-20020a17090a2ce100b0025e9519f9e7sm2472242pjd.15.2023.07.11.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:29:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 11:29:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in kthread_bind_mask
Message-ID: <ZK3JrFCT3EsS2mxG@slm.duckdns.org>
References: <0000000000005ca92705d877448c@google.com>
 <ZKx8+B3gI9/1g5A3@google.com>
 <CALm+0cUurycz1=pt85sChA2dpzhk3KNLmTo5vfSb_uObOxQPRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUurycz1=pt85sChA2dpzhk3KNLmTo5vfSb_uObOxQPRQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 11, 2023 at 12:01:48PM +0800, Z qiang wrote:
> Full email path here:
> https://lore.kernel.org/all/0000000000005ca92705d877448c@google.com/T/
> https://syzkaller.appspot.com/bug?extid=087b7effddeec0697c66
> 
> 
> static void __kthread_bind_mask(struct task_struct *p, const struct
> cpumask *mask, unsigned int state)
> {
>         unsigned long flags;
> 
>         if (!wait_task_inactive(p, state)) {
>                 WARN_ON(1);      <--------------------------trigger warning
>                 return;
>         }
> ....
> }
> 
> Inconsistent task state trigger WARN_ON().

The usage looks correct to me. The rescuer kthread was just created
successfully and did complete(done) in kthread() and then should be either
about to sleep or already sleeping in the subsequent
schedule_preempt_disabled(). Either there's something buggy in
wait_task_inactive() or task state transition itself, or there's something
else which somehow ends up waking up the newly created task? My hunch is the
latter but it's impossible to tell from the available information.

It'd be really great if syzbot can find a repro.

Thanks.

-- 
tejun
