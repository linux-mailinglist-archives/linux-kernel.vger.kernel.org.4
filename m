Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49C5B4189
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiIIVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiIIViw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:38:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37621365CB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:38:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso2479485wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2Y+NLNuQyKNaFU6mPTgzkQeYfosTVSCZJmxTb/6tykg=;
        b=S9fvTRoZDs1adI4sC3PL20INBwJC7nCemJe/AWoDTwEcfdlhgkbeQ39SsyPpbuMjDN
         rVj+mRn1WT6L0Ojlq1kZzN8OWl+nNhMwBrR7+vfwU/D3QXYA3+ZwnOzrQf6mYAFLjSKs
         J/P+mrf/AGE3uU4oRTx3+dWzPl+UQfnW/BHvCnvvziTLm5OaWP+0Ha+d2oFsW4chiekM
         ZxcMhqfKh2Osx3CpVUUXCMb0Px0hkDa/gRrE/MccqDaNC2X00pNm/+7B4E0wK+lzmC8M
         /5eZN3sut+pyn9MKpdI2ajTtNp9TZeFLfKo6oA0DTH6ccWmsOXF9fMqs4BS8nsUdg1/k
         ID3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2Y+NLNuQyKNaFU6mPTgzkQeYfosTVSCZJmxTb/6tykg=;
        b=qXE/y0llmlac/g/2FlnRjfvb3EN9fqUtrOTajdKKNfSE0PJrLn+TZdMwakaqs7sB8E
         RatO9Kmvk08DE8S7+C4c/jp64Ip+K9xTtobP2mXRCl1wVQyWCxVj0aegnb63qqRVKoo0
         OyyBj7R4Zd6SWh2z0+aDPaDI0iNmlK6ysEYtW6cnzo2HRa6/oUIKZnvSmuY0uS0jhxxm
         VSQ1rIejU/aFP211SVtok2LOIkkWWM07XgRbM13Wsey2hXFwJLw4OMAKTLwCi/1GihOc
         u/LQEZkWdz3KpmgA6BLl3vWYKRfOZ/Nxjjc+zHycU3/l3EVsnPt2FVku6AalOiB3exJt
         mGIQ==
X-Gm-Message-State: ACgBeo3DTxH4p1aR01nwTs0qpxe8Fx+UCYRNxckhhQdMeE7ZP6MP9z++
        ETY8MwNoUJDOHeOEX+w68Ptdop+zolkVM16B4G49+g==
X-Google-Smtp-Source: AA6agR55Ji109n89/PIZXx7w8Zwy/UxdI6HoxoE5W3L937PCHDl99glgs5wvCTO9sZZ0mnsie1BGFRbQMfSmWlHgRwg=
X-Received: by 2002:a7b:c416:0:b0:3ab:73e4:c44a with SMTP id
 k22-20020a7bc416000000b003ab73e4c44amr6512861wmi.147.1662759529003; Fri, 09
 Sep 2022 14:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220909180617.374238-1-fmayer@google.com> <202209091432.5FEEE461F7@keescook>
In-Reply-To: <202209091432.5FEEE461F7@keescook>
From:   Florian Mayer <fmayer@google.com>
Date:   Fri, 9 Sep 2022 14:38:37 -0700
Message-ID: <CAJAyTCBuETy0oY-2tjvKxDDmQCsBdL2d4UU7Fv-ySKZw_S4DNA@mail.gmail.com>
Subject: Re: [PATCH RESEND] Add sicode to /proc/<PID>/stat.
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 14:34, Kees Cook <keescook@chromium.org> wrote:
>
> Normally no changes are made to "stat" any more. New additions are made
> to "status" instead. Could it live there instead?

Yes, that would also work.
I put it in stat for consistency because the exit_code is also there
(and not in status).
