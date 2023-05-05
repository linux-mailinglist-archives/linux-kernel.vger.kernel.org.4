Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF38F6F7D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjEEGod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEEGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:44:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C261A1;
        Thu,  4 May 2023 23:44:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaef97652fso9508025ad.0;
        Thu, 04 May 2023 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683269070; x=1685861070;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcb6du/6ul2ZZvoBbbIRcrwG3WFW/CFEGtboAQCpB8Q=;
        b=XOn6y/ARvg1r5XZCjSjMNtACAHAOUD8gJwjoODAr66ppagVjXmAc/xwe1JQyM1bNYa
         4grxNXYiXqsQGbOthBW7zJJEvY5DXrX2zDmdfnpbcR0qfUUi9EFsCio+XtG8ki/7fEKs
         Bg1UU7I9Bj0+qa0aC2Tr7oyiONAYyfmqP62dpNvhk0peP4hE+I1vxJ9kVFlrBOdj0qan
         LXBeU/jR5vtW8CLQxm15j4GDk1AcdwUoQvFaYaYGGabWeEHjUade6OSydy9fV8qZwxS0
         KsYTZFImYpfu6xQovgss37f2WadS8Oq+xOeoZ5wGQfnogYhn0pDTENJs3uhcSs8g7G9o
         VCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269070; x=1685861070;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcb6du/6ul2ZZvoBbbIRcrwG3WFW/CFEGtboAQCpB8Q=;
        b=iVXOgMqdPZiPz17U75vEnAHLNllyXT0YncA3mS3LiTvqnJfkF770PAsorstjdIC2DG
         I5JP4bEzbkNzHBV00rZbT9BCLRt4AjNXiGhoIguF4lnBJUlnJUUOhUaw59IqqcQRh8of
         b0Xwd/rSg2BixDFRoXudPYHwgJ72lR7+k4xUSTSmFnsduxQ7Mx3wdB4s+HE14zO91aax
         YhVSwXFkjbS/gsUwGXe+g1bherT0CFwZb1VQv2MxJpuuCLWEYQhiH9Ae1+85OtLPifd/
         LW8oVRFVCnIkdm9HOtNF76ITZO0WyBt0BcczQpbjCOdDwPM021Jdq0DRCdb22QZMSguv
         Xj6w==
X-Gm-Message-State: AC+VfDymA3MgfHiJRvmjHM6kOsutJXP6UcPqSRi2fsAG3ZpC20bhl2VJ
        Htn7QY//vZlrWhCJdz51/SFxKeks/Zi3piVujddqSaIiGrw=
X-Google-Smtp-Source: ACHHUZ4DaiEqMfo/Gg+hpCm76xziUt8ugcYQexmO3BwK9iOzJLyjVGrzPLkx1AxR2hu1QdhM9KVBmHmINEMxQjxuvF0=
X-Received: by 2002:a17:902:7481:b0:1a9:7e26:d72 with SMTP id
 h1-20020a170902748100b001a97e260d72mr441025pll.9.1683269070005; Thu, 04 May
 2023 23:44:30 -0700 (PDT)
MIME-Version: 1.0
From:   Ujjal Roy <royujjal@gmail.com>
Date:   Fri, 5 May 2023 12:14:17 +0530
Message-ID: <CAE2MWk=wReoU4W62=oUt8a_GBMdvJBCWYO3rUxvoX3i-SF-6Tw@mail.gmail.com>
Subject: Sending Multicast General QUERY with unicast dest MAC
To:     Kernel <netdev@vger.kernel.org>,
        Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am not getting much information from RCF about MAC addresses, apart
from 23 bits of the group IP address to be part of 3 octets of MAC.

So, can you please give some input on this. Does it make sense to send
an explicit general QUERY with dest MAC as unicast - to any wifi
station on connect?

Thanks,
UjjaL Roy
