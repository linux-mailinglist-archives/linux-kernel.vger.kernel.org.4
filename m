Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF775648D60
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 08:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLJHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJHDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 02:03:11 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0448BC8;
        Fri,  9 Dec 2022 23:03:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn7so7114053plb.13;
        Fri, 09 Dec 2022 23:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JRsLt5pIj5AWLVtbICugD8KtAqaAaJj0VNGP9H///Q=;
        b=drYcMpVK9MQMYBULJ7xVbG6fl73I1AdoG2n1J4faUFphnPioQJcumks7+/VT/NXdiO
         HptHhHOo5983tukdLvEB3K8/DdMo49WsRZqobeXgeHzWhfL46Hwgu0YWfhJl/wPvIb06
         iAQM3TXfO4K/oqlC7eoiUsM2d/+Q+RbtByXDbtpZrZSwUQvzFLWUAlMoYUUN3gbA8mCR
         6N3MrZ7bu1TurRBFWJqGd0ctq84a/taWlx0z9xvhG00s44UCu57yFdrKi9dQPM4Ziofw
         ilm7sShvBEwhhpLrEeajVDYgN0haw+fQF0YJ+m63ANfTWE8YB2UQDlTGOiz/jKMrgov8
         czcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JRsLt5pIj5AWLVtbICugD8KtAqaAaJj0VNGP9H///Q=;
        b=yTHckDUajXOpk36XttkrtFGZLL6AVxJSFMcaDlBMXE4FsNFHx3Fky1+rDxX3t9rzGR
         6DgX9GpwWsnSY0creXYs7qge6yA2r83coA33FStWFusb2LtA+0NTiFlCWC1mSBm/y2eg
         d/Y0unwezPUTGuhExaJDwistkzTOdnGddeiYj9YggLHO3o1LOU8KIPtdjN7g4KwvPRCP
         jnrp31ZzEIYTje3HrwpaPlXVrOygVIYYcVuVrJX1F2KThMv4IjiLbV9Rg6kFyJSdIYL7
         i5jvvd3l6ogvV5eJvOSIpiCtJYL00ihlWoiNJjmWUq3yeMMLkObsT34ULcuGHGqiBkdL
         Oqxg==
X-Gm-Message-State: ANoB5pl/opgkPQWPBttU33M5hes1I2yh99W0OIdH1RdRM6bE1r0+WJPd
        CeTGHx6cMMgiWm/tv2ImLiDnChCMsZrSDg==
X-Google-Smtp-Source: AA0mqf42JD7hGze8TaqLHVToQM2Rts6joBYCSAFb1X8pzLtiZ3qC5ogUG19oZ/zbLBZyVzo9BF91Yg==
X-Received: by 2002:a17:902:8a8d:b0:189:c536:c745 with SMTP id p13-20020a1709028a8d00b00189c536c745mr8421302plo.2.1670655788962;
        Fri, 09 Dec 2022 23:03:08 -0800 (PST)
Received: from Mahakal ([2401:4900:1cc4:a635:d9e5:2161:2ffd:ffe6])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b00189951514c4sm2331108plh.206.2022.12.09.23.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 23:03:08 -0800 (PST)
Date:   Sat, 10 Dec 2022 12:33:02 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        mintupatel89@gmail.com, vimal.kumar32@gmail.com
Subject: Re: [PATCH v5] Common clock: To list active consumers of clocks
Message-ID: <20221210070301.GA3846@Mahakal>
References: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_NO_BRKTS_FROM_MSSP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
We are eagerly waiting for ypur response. As per your suggestions, we have updated and sent another gerrit with message Id
<1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>. In this new patch we are listing the clock consumers name along 
with consumer id in clk_summary.

Please review the latest patch.

New patch details:

Message ID:
<1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
Subject:        [PATCH v5] Common clock: To list active consumers of
clocks

Regards,
Vishal
