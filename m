Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512516865D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjBAMXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjBAMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:23:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC657EDA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:23:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n13so2770270plf.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TmW+83D4k+IrbCdYMzXDO8Tj9MpJav0XaxfanWpefQ=;
        b=I5U/ro+QsRr0QjuYf4lEaPFcjn4T3ultNGoWwNM7VxnllmLJJM43O/A4EdK78c+gYN
         LD/yvPN0BMxT3Oct4S9gm14T9/ahFXkBF3DHOsuE+R+5dn8oIt/L2GVdV+Opeu2UQUmI
         XSmYtsktQ9oDE/OvCXFlb5YPxFqMkbbEz/0joqxrGGrZ1UnbStCp3qNFcFuRGs8TiFxn
         UQU3ml3wD8Y5U+Jln9RnOKi9prgJbiyt11WYS5L/ucSRfn05PaCobkFwfVwxARpNC1Pu
         4BdqDWyvdbhktsDDxA7XthNi8u2A4KOD2vj+aWfujnMB0tR0Gp75JTZ6P7a9Xsz/ryzW
         QVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TmW+83D4k+IrbCdYMzXDO8Tj9MpJav0XaxfanWpefQ=;
        b=G7Iuiw/pn+gpH5cI4y1RkUm3NFxdwvmJcSf86mCB/5HSdJ6hdApmvXKk+aIwR1QDz8
         WT558ls4Q6bjlC7VSFpeP3OwnknqfPNkRwLaqXWqOARl4Yd/xfL7COfOIOFjQxKeltD0
         OfOCS6mp/BHVHEC7g1FNMcqh5X28wWl51bPufMWXGlbFnGY5RMMryraXZzytUVOkCZB/
         4dzwUHNbRj1h5mu9WMWLTHSg1cGelgvj5BRxdWWna7/xem7Zs2FXz4f/52ZtziG219na
         eFQKrN5nIK8l4pm/MCTtGjpvs7plz76B8KOUX9vVCESgU3TeFv0wmRKROBFajyK7C4ms
         Hrlg==
X-Gm-Message-State: AO0yUKXlqpJKtWfqaGeoSxbStTXXjqz61YB2Y0F6KDmQCJ4cG4/9xGgY
        kGd6BzzgkQxt9xDngkspQDz2JjrRjx4=
X-Google-Smtp-Source: AK7set9lOEgQz/SUAUmSfBUuhQJpbhyySXachWSl8MnURgyFYlXm/kqYjHVG4Os61imcmeur3J0G0w==
X-Received: by 2002:a17:902:ea12:b0:196:6297:bbc2 with SMTP id s18-20020a170902ea1200b001966297bbc2mr2907338plg.58.1675254190327;
        Wed, 01 Feb 2023 04:23:10 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b00195f0fb0c18sm11745867plq.31.2023.02.01.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:23:09 -0800 (PST)
Date:   Wed, 1 Feb 2023 20:23:04 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     xiongping1@xiaomi.com, qixiaoyu1@xiaomi.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2 v2] f2fs: fix wrong calculation of block age
Message-ID: <Y9pZqOMBipT2NZk0@mi-HP-ProDesk-680-G4-MT>
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
 <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
 <7c12ebaa-4d3d-e475-dfb2-7b459cd26e64@kernel.org>
 <Y9ZWDVV3HJ431Fis@mi-HP-ProDesk-680-G4-MT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ZWDVV3HJ431Fis@mi-HP-ProDesk-680-G4-MT>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > How about updating as below to avoid lossing accuracy if new is less than 100?
> > 
> > return div_u64(new * (100 - LAST_AGE_WEIGHT), 100) +
> > 		div_u64(old * LAST_AGE_WEIGHT, 100);
> > 
> > Thanks,
> > 
> 
> We want to avoid overflow by doing the division first. To keep the accuracy, how
> about updating as below:
> 
> 	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
> 		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
> 	res += rem_new * (100 - LAST_AGE_WEIGHT) / 100 + rem_old * LAST_AGE_WEIGHT / 100;
> 	return res;
> 
> Thanks,
> 

Friendly ping

> > >   }
> > >   /* This returns a new age and allocated blocks in ei */
