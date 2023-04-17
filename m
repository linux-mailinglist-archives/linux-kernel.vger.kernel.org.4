Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F56E457B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDQKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDQKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:44:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479B5B9C;
        Mon, 17 Apr 2023 03:43:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so12847498wms.1;
        Mon, 17 Apr 2023 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681728145; x=1684320145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FSsTNaAxDVrnnWZoYzSsuW1bfOx2KirKh1RVOBinvY=;
        b=bImlZtJsk9iREVOmEf/RbWim78bXjszsA+dO0JytrrS7kWGgf/T8r2bAZugCyK3Hzu
         JbjVo8JYuYY//n4ElWQCvFHPRWlWsFgXSgyFR0G7BSYfzyELmgCT5RMU+kTSaVqojf6b
         +mGH1Ej5yCIoLM5//rhimXdrtyqhZJlSZW7BbsItuvx1XOCYSS3EhnQIdTJjsx2F2DZ+
         f2rSsW5nMMQu0CcMvCAGc9eRRjST1LPPxhOsqUzzLf7RZeZAGy+TKtbceMbq6Gtspg0+
         P/l3Bh4dATWSrKGsKUyw/JGU6CTblM+GD0u1lfvT6eidKtUXvDjGAaa81mHlMArX/qXL
         BH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728145; x=1684320145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FSsTNaAxDVrnnWZoYzSsuW1bfOx2KirKh1RVOBinvY=;
        b=BsPN7jrwPXzugNd9H9qI6UZ+sNs7R3wS5nEM2WB5JpJVQb0TosE8aZ/YT+Lg8dhnGL
         anluikO9oGYVUgPTafUaqNYs5ZUcy+0TWNIm0+1vo2M3aBjI/L196cvsGqQlh3Hw1TW6
         4/tggKdUJrMyamLiAUrroWt6gyabq/SPkPq8UErR7wl1GrbYZG1iqv3Bi4XFGo7CcgXQ
         2XAuyeiv/GwmSPpppMyGfp7OhyCVeACirCwc8BoNSnIIiLcZ9JINXSK0ZAzrp4o4LP5K
         Y6oCBobAwjj29aKPzYcC7qDb96TZAHtZ0E/dYP/R2EUmPMoK5g6nOhGQIgsNrl+BqTio
         p6dA==
X-Gm-Message-State: AAQBX9dvw6a1RI61cOZjl8tVScb9h1eotKZ1N7/v84Li0yX6vCfpRpA7
        aq7M8Etx24fXxEx1gf2Wgmg=
X-Google-Smtp-Source: AKy350YgtqidShU+Z+BRMWKOzSY0N6RpgZt7pJjc0/NbbrBY/lJjWRKH94XwvA30WZXkQLYokVa9XQ==
X-Received: by 2002:a1c:7717:0:b0:3f1:75d2:a6a7 with SMTP id t23-20020a1c7717000000b003f175d2a6a7mr760219wmi.36.1681728145521;
        Mon, 17 Apr 2023 03:42:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c230f00b003f16fdc6233sm5189129wmo.47.2023.04.17.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:42:25 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:42:21 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>, Vicki Pfau <vi@endrift.com>,
        kernel-janitors@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Message-ID: <011c00e7-c351-4331-8be4-1c184d5773e1@kili.mountain>
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
 <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, we should be thinking about how to detect these sorts of issues
using static analysis.  Unfortunately, it's not as simple as saying
"We know this variable is NULL so don't dereference it."  The problem
with that is that many times Smatch sees where a pointer is set to NULL
but not when it is assigned to a different value.

What we could do instead is say:
1) If a pointer is dereferenced and we know it is NULL then:
    set_state_expr(my_id, expr, &suspicious);
2) If we set a pointer to non-NULL and it is marked as suspicious then
   print a warning.

This would generate a warning for cases where we dereference a pointer
before it has been initialized.

It is not hard to write a Smatch check like this.  The first draft
approach is only three functions long.

regards,
dan carpenter

