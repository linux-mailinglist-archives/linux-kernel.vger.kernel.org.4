Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A45FC6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJLNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJLNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:51:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194461B11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:51:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot12so38167608ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5YUZj2preUeh9QTI6ueyx+iJV4FKrSrouAkmiMJdSE=;
        b=JerlzHUNFpL509UfrBoY2mMGhtVuc6daN7sp4Gk+s2hlIIcsYbx8ygP60vLtgvRyWd
         ZN0AJ4g2MaQIuvuGDCLBvji/aB51RrKDa8kl9XrIi0K61zMBbTV5T0aRPFfB5kmEpkAp
         aqz03VOaOYuGDyJOuYZmgL2YEV0GrVfcQ9ybw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5YUZj2preUeh9QTI6ueyx+iJV4FKrSrouAkmiMJdSE=;
        b=mPoyrVsuCjOIqo3sdYcWfXYVgILPF1Z9wZlvyeTwacvsxMpZhfKN/vSXX0AnEa87yj
         LAzpSzlESDaz+yXRArinKiXBwi20Hd3LeUpqz06WUgBjnYFDSC1d6O6y0SW9s2GqrEEO
         4xiL38YeCSmZdTJuQh5a0kzT5L0SSIgafwAubktbQWPYODo0Wj6RT3G5e8mwH+pD1Zty
         jzJm7Q4e3YrAHxzfVXIFWgp9FBAWxJ1PBwtHz26w2XHcJl/m39PtUzIMSt0aTgVKQt7n
         9i+5m6AseMefe/8gnMHg5+UWmRwxb3y6iIq23JmcXkTK/DJlA1lfzwRGGVFWTTustK4Y
         OvFA==
X-Gm-Message-State: ACrzQf3mWmwm2MGf9eiIhitgHFE45PUv3Rj1sPUlQgXdSBV74ivSCtH5
        9JGMPPW2r1ZehQM4Bqc/zlmQnHIKwYiyAlp8lrOKOg==
X-Google-Smtp-Source: AMsMyM5PlsAdkYM7Hv6NTbG3Prb4EoPknhlg2TtlxfGkE9Y0vlB/NYqoumzLWAMVNZ6HIAtJpKMFAqBV2cv/+0kAmdA=
X-Received: by 2002:a17:907:62a1:b0:781:b320:90c0 with SMTP id
 nd33-20020a17090762a100b00781b32090c0mr22056168ejc.255.1665582664889; Wed, 12
 Oct 2022 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220928121934.3564-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20220928121934.3564-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:50:54 +0200
Message-ID: <CAJfpegsNeeuCoF8M9TuvG3YY_Tv1pgqasR5Av0xsa3jxsnJZqA@mail.gmail.com>
Subject: Re: [PATCH] fuse: always revalidate rename target dentry
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Tianci <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sept 2022 at 14:20, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> The previous commit df8629af2934 ("fuse: always revalidate if exclusive
> create") ensures that the dentries are revalidated on O_EXCL creates. This
> commit complements it by also performing revalidation for rename target
> dentries. Otherwise, a rename target file that only exists in kernel dentry
> cache but not in the filesystem may result in an EEXIST.

"...will result in EEXIST if RENAME_NOREPLACE flag is used."

Applied with the above change.

Thanks,
Miklos
