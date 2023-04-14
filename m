Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734696E18EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDNAXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNAXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:23:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB9E4E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:23:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66895aafdso1440635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681431796; x=1684023796;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPlT04Li3mmLsWP0TB9ZFLKkoXnJzg7ZzLsPJrNqauE=;
        b=oYNX4rkxSfvVJTrd9yYASBFZuipEg8Ilgqpu2LdnLTRrN4dxhltuJvJJmLpTltMtGR
         nfwT/kd2s/+vefkL1+aKhPlHMVnqQuPp4eX/+zomYhYQfftVrL/IeSBaPnwNxeYbUUDA
         7vwxUmNRuLRiLEuQdfaE5Gsh0gU52N4p7Q6hZKqMPfRM/Zv/XBw87MSxIwi7gG/FJpmU
         RkpMDDw6g7M/5JgE0ZkaaRpdUFNlcbwymH7m+FTXrRmPNiRvPfxvEyv1QgE2XDu60GKe
         E7sN+eRkp8vYnB/4hK6ncQhZ9/d41olrp5c6FyMGscw39MSUb7ctinIXpAU69DO7C780
         Kfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431796; x=1684023796;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPlT04Li3mmLsWP0TB9ZFLKkoXnJzg7ZzLsPJrNqauE=;
        b=LOg7cXNL+vZ9N4PcmLX5TNWkTgqth20Dk5bqkRVX33aDiTSn54Q9LudBGoapVMkncG
         +Wrpcy3TM3DAWFKP7oyxdkfDwd0yYlQTrHnmW73Icmx/Zv5bmOJ9LypzDmlbBPtTnXaD
         l49/0MTvQJmNJtt76WkJtQH1NBqVts+bdOGBno6YsvuAGmtugPBv1LVzKncbAT/6yW4y
         TS8DmsbsZbSATMsM8iTB7tCmh8xAsYZdUogOf7a5KE84MkQLML6z31k/BdG5RdtV4Ay5
         J08RUPYd61bUIZIzXbMkIxoMor55U9I1RaARLbeBk8CT+Cz4OWcPiUU+RQsxJv0KYUI7
         jGLA==
X-Gm-Message-State: AAQBX9cXBskKys9bUVihjDzqy45t/1w5oBj0k024npRLuUc4+iSRi0TC
        CufZJJS2BLGC4vKFEO5k9j93qaLmrOE=
X-Google-Smtp-Source: AKy350bG1P3KdLoyBrx2CFGAJC52zLhrVyAUCBtphTUlxsL9toxx33D+EERwo7sXRga6AA/z592KvA==
X-Received: by 2002:a17:902:e746:b0:19a:7217:32af with SMTP id p6-20020a170902e74600b0019a721732afmr721994plf.5.1681431796043;
        Thu, 13 Apr 2023 17:23:16 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8200:33:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902789100b001a1ca6dc38csm2001920pll.118.2023.04.13.17.23.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:23:15 -0700 (PDT)
Date:   Thu, 13 Apr 2023 17:23:13 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Weirdness with bind mounts and moving files from tmpfs
Message-ID: <ZDic8fx1NQirB2+d@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

If a file is copied from tmpfs onto a bind mount, the contents update
as expected.  However if a file is _moved_ from tmpfs onto a bind
mount, the old content persists.

For example, my PC has a tmpfs on /run:

    # findmnt /run
    TARGET SOURCE FSTYPE OPTIONS
    /run   tmpfs  tmpfs  rw,nosuid,nodev,noexec,relatime,size=5737612k,mode=755,inode64

Set up a bind mounted file...

    # touch /opt/file
    # echo one > /home/file
    # mount -o bind /home/file /opt/file
    # cat /opt/file
    one

Coping a file onto the bind mount via the tmpfs on /run yields...

    # echo two > /run/file
    # cp /run/file /home/file
    # cat /opt/file
    two

So far, so good.  Now do the same, but with 'mv' instead of 'cp'...

    # echo three > /run/file
    # mv /run/file /home/file
    # cat /opt/file
    two

At this point, the contents of /opt/file are stuck forever with "two"...

    # echo three > /run/file
    # cp /run/file /home/file
    # cat /opt/file
    two
    # echo three > /home/file
    # cat /opt/file
    two

What is going on here?  Is this a bug or a feature?

Thanks,
Richard

