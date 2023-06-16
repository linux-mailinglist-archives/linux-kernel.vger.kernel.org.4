Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239D173339A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjFPOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjFPOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B630E4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686925890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z28CLtcrQdof3MedZbqou30uME3hJn/JD/yR/1bANbc=;
        b=WcRCIzoV/DvqxFVzX4u/5fECIDdskxLXfziRx3tFH7qCqu8iYgfjR+bbfJvnGwxJrbLGKd
        efEYgFnSYQZ6H1YFvwTRt+W5SnzczQlZZ6UxYnAKFRd1BuFSoGc1T3ETZgF6Bwcy73fiz1
        loheHhIr+0QmsyXd2bksQYfQ0yqNK3U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-e3RaLrD3Pt--KFS5prkFRQ-1; Fri, 16 Jun 2023 10:31:27 -0400
X-MC-Unique: e3RaLrD3Pt--KFS5prkFRQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f3932e595dso671676e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686925885; x=1689517885;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z28CLtcrQdof3MedZbqou30uME3hJn/JD/yR/1bANbc=;
        b=XwqTzFq/G0ldHLVuwORkoRAK6/vz/emX8eF9dc3swsyHS8AjFVC8WQCXNnDS7YRcTG
         iveIjuLexC2csih0/DKFGmEsqyWnJyeOeyF2QYEjHRPOTMhBSesAIxOOqjLXUavtZiZM
         RlPCKpa6H1+iXc+wChQcuNmihbAQWixBTni1a+gy8qU2W8UxwD6R6aWqbIGGDvvzC1qp
         gPXrkQIW8u7KK1fDy6BYLMnjdHYtpJqNpfDTI0BEJuuoXcPW+e2VJ0kO8lXmWHanjZOf
         Dy9xBLwMn3rAaW4KqbD875PEBsGtK6ugcWmX710NzPiFGWKiiNKCLOzcmQQxTQuGHlTh
         G+OQ==
X-Gm-Message-State: AC+VfDwtWVhkklorcTYvJ30QScyBNHaBSLVl8OJWoOcGFCCOoxT+OEUw
        jL6MlOLDusNZPEB4lWDoG1/kSbEjim8ejvK39dk1am/IUNPewpF/Z0PfynOpZSxVqZ4NRq16dBI
        Unc0JvPufwuEXNe6pEegw6i/2
X-Received: by 2002:ac2:465b:0:b0:4f6:2e5c:de65 with SMTP id s27-20020ac2465b000000b004f62e5cde65mr1769877lfo.28.1686925884989;
        Fri, 16 Jun 2023 07:31:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cInGRac5xeuSJA47MRMVrTgpexJsXAo0jtV8tsv9XTd6uNvmyRY37xeO0WPkt60MCgl1ItQ==
X-Received: by 2002:ac2:465b:0:b0:4f6:2e5c:de65 with SMTP id s27-20020ac2465b000000b004f62e5cde65mr1769851lfo.28.1686925884631;
        Fri, 16 Jun 2023 07:31:24 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0030fbf253c82sm15422236wru.104.2023.06.16.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:31:24 -0700 (PDT)
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
Subject: Re: [RFC PATCH V3 3/6] sched/deadline: Move bandwidth accounting
 into {en,de}queue_dl_entity
In-Reply-To: <a466fa588e7ded15747b68d9c796f5c7454abdc6.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <a466fa588e7ded15747b68d9c796f5c7454abdc6.1686239016.git.bristot@kernel.org>
Date:   Fri, 16 Jun 2023 15:31:23 +0100
Message-ID: <xhsmhv8fnwkas.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> In preparation of introducing !task sched_dl_entity; move the
> bandwidth accounting into {en.de}queue_dl_entity().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Now onto the server fun :-)

