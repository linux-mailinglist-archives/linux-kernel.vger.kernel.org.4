Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E5719CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjFAM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFAM4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A4191
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685624115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NNOxzOcErgJCqL4q/p9uBhOs5ss6WduW2i2jw8kKEC0=;
        b=c9swZlYQWXGfVBA9ZyLuFEJGLsdxFmUdOnUispldALhA+eY/1O49odDl87H3wrHGGofOmz
        yiRuSzSpviC/SLgJhr34Yj0PmEBiNW/ZQ0N5LH3TR1AebTeIg0AGdfYNqoLOrBQw7qcSx7
        z3Bl8acl6yFRenFJPKqZ49WzrlC8oic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-yqEdvJtIMQqqYP1hzgXfsg-1; Thu, 01 Jun 2023 08:55:14 -0400
X-MC-Unique: yqEdvJtIMQqqYP1hzgXfsg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6f2f18ecbso5142315e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 05:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685624113; x=1688216113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNOxzOcErgJCqL4q/p9uBhOs5ss6WduW2i2jw8kKEC0=;
        b=jtO2XGRRfSYqS72cY2Qh7sIjhiGGP5+ids5gX0aaJErr9fB2vlTAwK5WpU+cftLfPV
         vX5LQOGVDQPwzkIbcgvd3yTX/mWx6uPdOUuf94drRadbtbt2XHdgpeHYiDJZoiCCD2pR
         fnzFExi4WQSAoiejVut4U5XYeN/fJTj2xxX5fZR9Gyw8wbhjpAAQMvKKUt/Dzqtr3aQp
         3m20Gt3KcvDtlHmmd+9dY99Q31dA3MyxoyX/A/FYhVr1y8YZibxK2IYdKJDz67+EOMKn
         W1EUbIbLCu+3pJN1X9OPHtnWE0+BhuvTj3Bapg9F+n4rWWDSTa+PvpEO2f5JzbK1lwR/
         nvFQ==
X-Gm-Message-State: AC+VfDytDbGVnnn44nUUY7lQwAaJ7sRsOmIXK/XQNsKYTB0eIvBS7oLk
        I2ZWD9lMtWNtXouUocPmmFKa3QxzB/eG5t9VtyCf9chJY7np0iPNV9tMYfdSj2TX4Bn0vwFeC/e
        jcR0XmC94ir5q4J5sb2zxVQhQ
X-Received: by 2002:a7b:cd91:0:b0:3f4:ffaf:a862 with SMTP id y17-20020a7bcd91000000b003f4ffafa862mr2056798wmj.12.1685624113199;
        Thu, 01 Jun 2023 05:55:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZEHqQAjMNM5hSipoal2Y0M7MURKTmpadnHvObYfh6OrZOJ9G8ArN4VWfB06DSx0EMyAmVFw==
X-Received: by 2002:a7b:cd91:0:b0:3f4:ffaf:a862 with SMTP id y17-20020a7bcd91000000b003f4ffafa862mr2056778wmj.12.1685624112892;
        Thu, 01 Jun 2023 05:55:12 -0700 (PDT)
Received: from localhost.localdomain ([176.206.22.140])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030c4d8930b1sm630087wru.91.2023.06.01.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 05:55:12 -0700 (PDT)
Date:   Thu, 1 Jun 2023 14:55:10 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     luca.abeni@santannapisa.it,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] sched/deadline: Update GRUB description in the
 documentation
Message-ID: <ZHiVLuyZar1LF6H0@localhost.localdomain>
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
 <20230530135526.2385378-2-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530135526.2385378-2-vineeth@bitbyteword.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/23 09:55, Vineeth Pillai wrote:
> Update the details of GRUB to reflect the updated logic.
> 
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

