Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8762D744A7D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGAQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGAQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:18:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BBF9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 09:18:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992b2249d82so320376266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688228297; x=1690820297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5eWSyyKs8RR0TyyRVexZen34BrNwHGJB20VMI/Jj/I=;
        b=UcOe6qC6+Wx92ldvley3r6VlIwrpK1VUj6SmJr+XM2vLJ9q3fXIM15yCNH4P+nrbBp
         wNhzuNS69MT6j6NU/mTwppcWimFkIKVTtdASc3Q7GIlpLz9OozBvdcKsR0mrNKWL5hHT
         0mFIf/aphKj1NfENidQsd01co45eUBl3dkbn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688228297; x=1690820297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5eWSyyKs8RR0TyyRVexZen34BrNwHGJB20VMI/Jj/I=;
        b=Rr2bGBMMsY7sALNCD3MA/gzp+/qGUMvSLymbN6JNSAn68Zh+f7j3nV8lZTi5SGcYtq
         FYhRzH/V4O20S8zsvkvK4BKkDBeISVThoZYnne0zPWFmc5xoeEldrT/fGYV1RH19qMVs
         eWecYqx/OqvG5wT2T/SLyohm7QBizj2HLhyi5IcJrWLHlk09fe6lV+hhvCMC6Chp8DQy
         Qj2AaKcy0aIDrDAsGJqBvVQlO1tJieMMe04GMfnFSKY01sKh8b++fuR12J1jXZmMaZ2D
         HnMxH9xSw9bAlOBxqxozwWynIUim6Zy1ujj4mjQVl7heQ2vegCDIo9Io+EWKuxKSHtAg
         WmZw==
X-Gm-Message-State: ABy/qLZ4AJ3WZ977YwTtKuJgQYMaID5ek+EVTxPUt+CqsKrnaxWS/oKw
        QVy+FZNnQzszb50341UaSisdaEwMTjeu5Phmk+q5DtYj
X-Google-Smtp-Source: ACHHUZ5zlU9U2VcKpiUDyVx4b0SnHGiQnjKC4PZ1bNHe+z59wY+ouRYIY9lbUKIJZHZwVwr+5a9JQw==
X-Received: by 2002:a17:906:b20c:b0:97e:32e:c1e with SMTP id p12-20020a170906b20c00b0097e032e0c1emr4091106ejz.55.1688228297342;
        Sat, 01 Jul 2023 09:18:17 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id cw20-20020a170906c79400b0099307520b8csm1445725ejb.29.2023.07.01.09.18.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 09:18:16 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51dd1e5a621so3562660a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 09:18:16 -0700 (PDT)
X-Received: by 2002:a05:6402:2023:b0:51d:9dae:a591 with SMTP id
 ay3-20020a056402202300b0051d9daea591mr3508329edb.21.1688228296264; Sat, 01
 Jul 2023 09:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZKBRDMx96q25piLr@arm.com>
In-Reply-To: <ZKBRDMx96q25piLr@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jul 2023 09:17:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQjwGzMc+R_UuFLtYLBdTPSBJ2GW6y-sCReq2dhwv-oA@mail.gmail.com>
Message-ID: <CAHk-=whQjwGzMc+R_UuFLtYLBdTPSBJ2GW6y-sCReq2dhwv-oA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fix for 6.5-rc1
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2023 at 09:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Here's an unplanned second pull request for -rc1 with a fix from Will
> for the SVE registers saving corrupting memory.

Christ, what a disgrace.

Please make sure to plan your bugs properly ahead of time in the
future, not this shameful disorganized unplanned shambolic stuff.

            Linus
