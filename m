Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD06755D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjATNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjATNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:32:44 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386D38B66
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:32:42 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4d19b2686a9so72133777b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtikuj8gXg3ypC8rwxOlgyPtFSBc8FnCeFcbONAIJEg=;
        b=jc6e/Yw01Ua3nKPTtoE6QdlpYh11OawzC5k2RyRlPs9s5T3StuXm5/LmYIJhLKahv/
         2pjv5Bceh+02PEqr8zcjaIYGKKODUMHlKdIIGvtfDosXnDoDWKFN/6g13rmyTkbdhE13
         xPPqGznUq3FWwtM7LeXy7JfhyjA9TBbUky9so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtikuj8gXg3ypC8rwxOlgyPtFSBc8FnCeFcbONAIJEg=;
        b=eArPsT0DYtqWqmQQtBhvaU50XHUSHXsU7Vg7oVF6zG9Tunidq8DR9NeSDg8d4+DoND
         jtrlIJCzovKxIjAe3nA+p45XMQR2KEULVQn8IA0UsvvSjH1a/ntalRTLB6U0ydvQGRps
         DyeX//l9P1AFWoLE0xSdVVSobBly1za83MVLQwUw3/T7OWIzIihQIdxY+58Nsgb6PooP
         1QlUpda8azYwfEFMZ/ob5YEUfTeGXfgXyBHu4y8f+avvHRkkxSI5/pPDXi+wO+W56ElK
         12kHqb1KqJ7DW4UI4MUZEs8rYdpRVgkc02CuqU94znlYF6L7ToAU15H0I+FS8eFy0XIv
         +Erw==
X-Gm-Message-State: AFqh2krUVjOvZfLC6rgjSBAw19WNTBeiLPTAKFsy3syKzSde7MJYAiO5
        ERIzW3sk/8d2WQ1qrCI8y/zrRhARX1Uls7J3
X-Google-Smtp-Source: AMrXdXucZSgAtWPVbcvFfMkOhri9I2bEIntD9GOazgMIFbdwQ3WbLLOEvmS76n4yl9IAjf/TsM5thA==
X-Received: by 2002:a0d:f046:0:b0:364:1ba0:a71a with SMTP id z67-20020a0df046000000b003641ba0a71amr10198880ywe.41.1674221562125;
        Fri, 20 Jan 2023 05:32:42 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006faf76e7c9asm26472941qkl.115.2023.01.20.05.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 05:32:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem
Date:   Fri, 20 Jan 2023 08:32:30 -0500
Message-Id: <37171A49-82E9-4008-9B5B-1CEEDC9B653E@joelfernandes.org>
References: <Y8o9Mh1ktK0jdQy9@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Y8o9Mh1ktK0jdQy9@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2023, at 2:05 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google)=
 wrote:
>> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
>> However, cpu_is_hotpluggable() still returns true for those CPUs. This ca=
uses
>> torture tests that do offlining to end up trying to offline this CPU caus=
ing
>> test failures. Such failure happens on all architectures.
>>=20
>> Fix it by asking the opinion of the nohz subsystem on whether the CPU can=

>> be hotplugged.
>>=20
>> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down().=
 ]
>>=20
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: rcu <rcu@vger.kernel.org>
>> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest=
 of the kernel")
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>=20
> Also want to cc: stable on the patch?

Oh sure, sorry. For some reason I thought Sasha and your AI scripts were loo=
king at the Linux-kernel list as well. Or are they, and a Cc to stable is ju=
st to be doubly sure?

> Anyway, for the driver core portion:

Thanks!

 - Joel

>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
