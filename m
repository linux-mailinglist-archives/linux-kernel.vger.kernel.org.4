Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3BD74C671
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGIQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 12:39:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93A8102
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 09:39:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso58815781fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688920747; x=1691512747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+VjU6ekC7fLbsWjPDFo7psEkQqUyoVl0DnTxnNmjzI=;
        b=NS98ciIeNWIjnY+RV1iWqTaoshb480OTVA7Mjxj+FXbnVcbFY1E/JZQ76coDxy7EM9
         R5ah2Q00jJgn8S48wPCDQbe2A1VDR5sS0Eua41mJVUuN/YWZLk87N7U01aMvvCoKJj4B
         pc051saVlZpg63qRiR+98UgP4THA9nS/ZEWU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688920747; x=1691512747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+VjU6ekC7fLbsWjPDFo7psEkQqUyoVl0DnTxnNmjzI=;
        b=ZI2LpLEkGBhLfsgrh6d86Hi0LYW1KZ+yhEU7IRA6XWXTLJ8OsTqowib+XBzQw5UUU1
         pDrKFgliFWiAcY41HHQfEv2XmfBXWvr9c1hq0JW7RlyjUw44krs9nQ92CjpiVfq9XVzj
         ES4JrYE/iB5lhMIEUCDluxXxtEpVYXJtas4wuoCok5txTPE+LNjDojTvV2ruYBxYD3T1
         OoQ8RL2T66OkWl+AT+7c3AEZClXDsI4I5e6wekBWJ9NmGzFuhg8+IJtyvLSLJrJEK2Z8
         AINnhEE86AqHr4Oj+YUhZ3q62tZ4rn24vS5sU+oTVyGGOBd5C/vrDQnOeJtX7ndCgiPp
         x6LQ==
X-Gm-Message-State: ABy/qLYdsh8pLmdeofbwOhNKk+dIUD1vQ8Akq/UuS0wHhjmew/km5GX+
        Q/r+KRtxWJZqrcjTglIpkUPzEg8dRvPDKgQwQPDatyAh
X-Google-Smtp-Source: APBJJlGebOaXdmgFPYaHuNyCaS/NloUCtB8NQAwsgURjCE1sqi2MY9jG+9vLpe3XvhLUR0N0tdyQgg==
X-Received: by 2002:a2e:3c14:0:b0:2b6:cff1:cd1c with SMTP id j20-20020a2e3c14000000b002b6cff1cd1cmr8208121lja.34.1688920746924;
        Sun, 09 Jul 2023 09:39:06 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e854f000000b002b6995f38a2sm1543593ljj.100.2023.07.09.09.39.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 09:39:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so5343110e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 09:39:06 -0700 (PDT)
X-Received: by 2002:a05:6512:2521:b0:4fb:c0b5:63d4 with SMTP id
 be33-20020a056512252100b004fbc0b563d4mr8466079lfb.43.1688920745736; Sun, 09
 Jul 2023 09:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZKor+IDTZ8OR/Xu9@athena.kudzu.us>
In-Reply-To: <ZKor+IDTZ8OR/Xu9@athena.kudzu.us>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jul 2023 09:38:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh81m71ge+8JW7ShXXVf0Oks16G4kqP0rW+moLZH+GR7Q@mail.gmail.com>
Message-ID: <CAHk-=wh81m71ge+8JW7ShXXVf0Oks16G4kqP0rW+moLZH+GR7Q@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for 6.5
To:     Jon Mason <jdmason@kudzu.us>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 20:39, Jon Mason <jdmason@kudzu.us> wrote:
>
> Here are a few NTB bug fixes for 6.5.  Please consider pulling them.

These have clearly not been in linux-next. They have commit dates from
yesterday, and feel very much like a "rush to get in before the merge
window closes".

I've pulled this, but don't do this again.

                 Linus
