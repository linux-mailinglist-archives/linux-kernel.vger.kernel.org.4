Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9085F4209
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJDLfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJDLfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:35:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007042980A;
        Tue,  4 Oct 2022 04:35:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn8so1539135ljb.6;
        Tue, 04 Oct 2022 04:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date;
        bh=hVFfXbUP1wcAzLkizbnnxRMsqSTUrNM7udZsfeOd+c8=;
        b=U0CAjPUdlXQyN1hNXp5sp/d0uJkVeimqyB68MayWYW8+cAMDqzTa9Eu7on+EU3WHT6
         GCDA8/qRkw2CpSoUyLnPjd7IjWu81iI5i+fHSVZEtJR5VtaKgg6JiRKZJcNNERINsO1a
         HqiwqCmB75UJzzPuEUch3FDcaE8z9dbOoZXhj031RifTAaH5zCPGkLtQeZduN9C13OwM
         H+msmtnfxZQOmJvohRy3VnFjjcfw27utPDrpg+Ke0Ao19pYnxwwfBXFh6NyqUT6oX2L/
         N46Jet7sUz/CgMtmeeJRiFI6kOjEU8u80FJr/1SCTqD7mL2dfJC1I2nT3r8ydQeBbOyh
         WZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hVFfXbUP1wcAzLkizbnnxRMsqSTUrNM7udZsfeOd+c8=;
        b=6a1IbmMDX/LVhQ+AewHqEDs0cXBMM15Ay4Kfzd1iElJAEE2mvstW62ppAm6Qw2ruEH
         zDE4tsDMrGuBhm5cDlOx5NIXi4CP+4oVPsSQ5lRNLfvAZ0j6eKbTkW8KekTIr/96+dCW
         CFMk09SGy70nY+YU2IUUWFUznWTsk6VE9XKZdNGDZpyCDqqOOprR2EIH/QNyKUjCekkQ
         POp8pyy6NIXhO/sjsKBvF/Bl1SwNwXUDJcBsVdlGs+2bCkhEOjtORNl9XM3K9AKw2GvE
         3lDdKpXJBri8zR+yyCe/NTijCGpaOQrEf1Zqbiq1oCNJKcztteMUVqcx1LCoY2JWdZ6x
         Orfw==
X-Gm-Message-State: ACrzQf2+KaN5yt2MaHrw7aRU4RM4Va5XyRfY0QO3Ph8Inaw+MvcNOii2
        ovJFfHz5O9fj3xXR2QFqq1s=
X-Google-Smtp-Source: AMsMyM74HSpZ1mWS5kw35tEVCRaq5nVfp2miyPR4OHr3qyOnnbxbRQm4Hp3YmKEegSzRptjQHtK2Cg==
X-Received: by 2002:a2e:2205:0:b0:26c:2423:a508 with SMTP id i5-20020a2e2205000000b0026c2423a508mr8355002lji.163.1664883329141;
        Tue, 04 Oct 2022 04:35:29 -0700 (PDT)
Received: from pc636 (host-90-235-28-118.mobileonline.telia.com. [90.235.28.118])
        by smtp.gmail.com with ESMTPSA id h13-20020a056512220d00b0049936272173sm1874477lfu.204.2022.10.04.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:35:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Oct 2022 13:35:25 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzwafYASrgKZ24uq@pc636>
References: <3F5B20A5-6E48-4603-ACBA-0A7947A9C457@joelfernandes.org>
 <9E3CFF3C-8956-4C44-8072-1CCD5E84CC4C@joelfernandes.org>
 <YzcVGN8v1yhgIlF6@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzcVGN8v1yhgIlF6@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> 
> > >> OK. Found the boot up issue. In my case i had 120 seconds delay:
> > > 
> > > Wow, nice work.
> > > 
> > >> <snip>
> > >> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > >> index 448748e3fba5..a56cfd612e3a 100644
> > >> --- a/drivers/scsi/scsi_error.c
> > >> +++ b/drivers/scsi/scsi_error.c
> > >> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
> > >>        * Ensure that all tasks observe the host state change before the
> > >>        * host_failed change.
> > >>        */
> > >> -       call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> > >> +       call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
> > > 
> > > Great! Thanks. I’ll include this and the other one you converted in the next revision.
> > 
> > By the way, any chance you could check android as well, just to rule out any trouble markers? ChromeOS and your Linux distro are doing well on boot so that’s a good sign.
> > 
> I will check v6 on Android. I will get back shortly.
> 
OK. Works and boots well. I do not see any issues with Android so far.

--
Uladzislau Rezki
