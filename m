Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA69733399
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345587AbjFPObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjFPObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98A2D6A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686925867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/2mIoPzS7FtFnEBAQvQCoAXb19H+IWjjz09Zgij3uo=;
        b=AXPyRYxH+UgXscbirOEm7pB0VmPXrNYMOABuOySlyMNA1PmOpLeMYYslih66Gc8T9/dpjC
        zzaadITy8T/wj87X8ZgdZ3J9t4OZQ/cB8iHBAfYxamC/pHKKi+0AvA7LPNBIUSa1hvejys
        FQDPLnyDQtGQMtbexreL/+2otFPQDro=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-RJ5m7TYuMYGzL901JQ6siA-1; Fri, 16 Jun 2023 10:31:05 -0400
X-MC-Unique: RJ5m7TYuMYGzL901JQ6siA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e4d85e1ffso973228f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686925862; x=1689517862;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/2mIoPzS7FtFnEBAQvQCoAXb19H+IWjjz09Zgij3uo=;
        b=PDXgMXM4lNwxzqKLXJEZTsMb37zXk33Y4Bs4wHcr1+UD2OFhlX+rm6uWwYQYp04a2P
         2QwYN745AkBKtovqgkO8TVBNKd4IjvbC094V7c0sJtjazgHoUNiWcO8Yc2qZ+j5SetAj
         UBBuIhJw8LBTid1zlFvATQO66EHeENLaVnDQ59Bor7Ur1gUCe72p2zHoAugTTOpEViDQ
         3f3U07Df9et1CaNAVN3TXiK3mDlgNZc9bODfoGmu+AK+i91bX9N08jpjarPA9uDPYoEl
         p0hNjNGciX+X65cdUzH2h0Ha7PsZFdjIYp0m1+YtgFxGZ8LJCJMPiA9Q+W4hfvNkEE7k
         Q9rw==
X-Gm-Message-State: AC+VfDyMP014S/76IWLoU/oYM5EtDFXg1ADdPaQptsI1pA3PEnjwsUEH
        FFaMgP4WFEyZfW9V219YeokI3bDZxoFOqTzBL8jiuggZImWxm9l7KYVVlh+I4it2kXgLjmdKhpX
        QUnLPfHyNB3ic/zqqCzhvGJtt
X-Received: by 2002:adf:e585:0:b0:307:8879:6cc1 with SMTP id l5-20020adfe585000000b0030788796cc1mr1570768wrm.71.1686925862315;
        Fri, 16 Jun 2023 07:31:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ylj7GiNex4hR4wACUdCfuUvZMGU/j4nwhgAJpCmOXsEsDCPKOKUFOuCX0919GrsRhszFr3w==
X-Received: by 2002:adf:e585:0:b0:307:8879:6cc1 with SMTP id l5-20020adfe585000000b0030788796cc1mr1570750wrm.71.1686925862125;
        Fri, 16 Jun 2023 07:31:02 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b0030fce98f40dsm9929312wrm.42.2023.06.16.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:31:01 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [RFC PATCH V3 2/6] sched/deadline: Collect sched_dl_entity
 initialization
In-Reply-To: <cb1e5f2fc80da2c7ef1017a2fee49be28fa07a94.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <cb1e5f2fc80da2c7ef1017a2fee49be28fa07a94.1686239016.git.bristot@kernel.org>
Date:   Fri, 16 Jun 2023 15:31:00 +0100
Message-ID: <xhsmhwn03wkbf.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> Create a single function that initializes a sched_dl_entity.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

