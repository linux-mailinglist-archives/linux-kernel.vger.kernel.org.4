Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72CD6C099A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCTEVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTEVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:21:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A3C66E;
        Sun, 19 Mar 2023 21:21:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k2so11162495pll.8;
        Sun, 19 Mar 2023 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679286081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RS1w7jufLTgqj4IcYaB/yvHrW7A9zSSTjyhf1dZzfNM=;
        b=UYZ4lXSE+fk2ch38kp24qVIB/g3NrO9tCkzEczF3dIhgdmMl48WycaRDmmxbb1lsLy
         TNz/NY7Q2knzvZ30g7Dexjv6RqakQ5SZDBonPBUGxVOLqKrLIm45yHLScaGcoMRawAAB
         Qo2tQSdCtJJtwXGjw7ixR1vXqS9VptmWqzUrVmjdGx0vjOb/jjufga1UOqIjcIwAv9et
         Ds0zY2MTiocqUm4E/RMabAhvQB2ApkVInO3Kr5P22HrWGxpKle9+SCHtCPIw2ThgsJy6
         UYGGNnwpc0KEnA5sMuSnq0NyTDVf1hdZ2X3lxfd1XW8R03bL5ftkuwUKP7e0ec8z/OUn
         VUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679286081;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS1w7jufLTgqj4IcYaB/yvHrW7A9zSSTjyhf1dZzfNM=;
        b=6oHt0JIt+xLyGPPUQlXh4ZZDCUyDHkM2YY+Uvs9al6JdmAA/OuKhxCDK7GPamNaulS
         3aFw04hV66V/49THImH8LELSAjErWwX1ijgR6GtI3jwT0nlhJNeAu+jqEB+ibvxcrce4
         N0PhgYu0Pq5OisGt917QYFvhDULmzApi0d1dR6pFzZiOHn+F5fAjaLznJmd0bLyPAHP1
         ERz7xRKwk/Vu9yexPexarQYONGj/wRuJTvt9c8pqTncGUPA02K8HzSnRO4PJOKWDZAEU
         npYOFhcV/RJhMrxhhrVUO6+WWww2g1HkOPMTvRw46T3EZojhLf7ickzeSyn1xb0fc9zm
         9n7A==
X-Gm-Message-State: AO0yUKUIyp18YnpVrSQidTnhlui89EAXFn3qCs2D5eNnrot9LAec2poh
        m+a/0d4uw/PoqcADJsRucfU=
X-Google-Smtp-Source: AK7set/OkIXlOAw6NRV+sFsu29XPd9i/eNuH4vDyF0QKBJE2m6aRrELRvriOwhclBp5/Tmr4BhgECQ==
X-Received: by 2002:a17:903:2910:b0:19d:1c6e:d31f with SMTP id lh16-20020a170903291000b0019d1c6ed31fmr14313851plb.29.1679286080664;
        Sun, 19 Mar 2023 21:21:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:687c:5175:b0b1:a145])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001a01bb92273sm5494855plb.279.2023.03.19.21.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 21:21:19 -0700 (PDT)
Date:   Sun, 19 Mar 2023 21:21:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: iforce - Fix exception handling in
 iforce_usb_probe()
Message-ID: <ZBffPEIWcmYcaXR3@google.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <521b63e1-9470-58ef-599e-50a1846e5380@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <521b63e1-9470-58ef-599e-50a1846e5380@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 07:03:00PM +0100, Markus Elfring wrote:
> Date: Sun, 19 Mar 2023 18:50:51 +0100
> 
> The label “fail” was used to jump to another pointer check despite of
> the detail in the implementation of the function “iforce_usb_probe”
> that it was determined already that a corresponding variable contained
> still a null pointer.
> 
> 1. Use more appropriate labels instead.
> 
> 2. Reorder jump targets at the end.
> 
> 3. Delete a redundant check.
> 
> 
> This issue was detected by using the Coccinelle software.

I am sorry, but I do not understand what the actual issue is. The fact
that come Coccinelle script complains is not enough to change the code.

Thanks.

-- 
Dmitry
