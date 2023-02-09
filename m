Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082ED690ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBIRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBIRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:02:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA259DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:02:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ml19so8483978ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kupmZX3BXgrz6kfwxlLZNQNS/5GSb4Eg8LQlhgMzd/c=;
        b=I6ATeBhENMAitFLdaGwM8nJS9m0KtUGF+tUOW+O51KZXysahKej88q4yfiYGjNouGR
         +HmLDZun6IsXLX700WaV6e6wOX8nGAYJSUoZQ04B0JSC8mVo5kpeJdOJNC6tGJ5qVkTc
         wKu0uhR4/t0eq/ecyTUNILssQCCiMIjysu8Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kupmZX3BXgrz6kfwxlLZNQNS/5GSb4Eg8LQlhgMzd/c=;
        b=DUUpjpyq+WqT27JNRlV4VAAMGhi4VHmtN9OHWyr4eepTFHNbTBoApEGsGrXx0GzmUG
         E3zupIrlEhj50XV5AGAhMnTEpsHAgoSHqBf5o7mkBkQn3dQOOwyW9Y/tMTf07ofWSHIS
         mfzer3Nbl4iRdfxeN/Oi4nCNtqLWtNZgJCj4QF/zeDG+TkqTvQNxUlZOB04wzJW7/QJa
         ofkyid1SEM1/+cVImn4fc5X+iTLDVQgbji/GAG9QB6XlruO3lLE6bTeIY0MFslKRsGPS
         oFHp0oqfnrjFikiQMFWXkf5rRjL/kQ5yqEuymcDI51iz9tlZZ0KcyJ2ytuxsw+Irpasb
         ehqg==
X-Gm-Message-State: AO0yUKUpzTukT/CAzPmFYPJlA1a/oaiEQcpWr7EKI1r08RPZ18ogjmwY
        DSzbaNEVOGfxVPFUcx1poWpHY27xMrzrnTapJxo=
X-Google-Smtp-Source: AK7set+oLhq1Weqi/dR6U9JMhIqHXa8wWYhHL8jIIDAw0+YywlEUYPmnUnLklqtG+bfocQVSV0L+YA==
X-Received: by 2002:a17:906:1619:b0:878:58e6:f1eb with SMTP id m25-20020a170906161900b0087858e6f1ebmr11692090ejd.23.1675962176414;
        Thu, 09 Feb 2023 09:02:56 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b008aa0305dbe8sm1082515ejx.80.2023.02.09.09.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 09:02:55 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id u21so2687193edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:02:55 -0800 (PST)
X-Received: by 2002:a05:6402:50d:b0:4a3:43a2:f408 with SMTP id
 m13-20020a056402050d00b004a343a2f408mr2101218edv.1.1675962175259; Thu, 09 Feb
 2023 09:02:55 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
In-Reply-To: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Feb 2023 09:02:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyY4ahLjKfvVho0CiCj-Nv0P3Edxqfu4bH4TcsZmsBJw@mail.gmail.com>
Message-ID: <CAHk-=wiyY4ahLjKfvVho0CiCj-Nv0P3Edxqfu4bH4TcsZmsBJw@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fix
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 8:44 PM Steve French <smfrench@gmail.com> wrote:
>
>   git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc8-smb3-client-fix

Hmm. Malformed git pull request with no shortlog or diffstat?

I've pulled it, because I can see the SHA1 matching, and it is indeed
a "small fix for use after free in readpages", but I really do want to
see proper pull requests...

            Linus
