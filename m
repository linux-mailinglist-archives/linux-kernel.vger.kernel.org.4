Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA75678412
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjAWSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjAWSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:04:36 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A814EB4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:04:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z3so9465032pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zi+iUdTui0eMYRh+bS6eQbXlcjJzEZc+EWZsqkgWXs0=;
        b=i2Q2SnN2NOq0NB2gvTP0FhB41NgE/wUme9MAS0qjjsaLwc8klFOiguv772mawVvnQW
         y8UosPW9CY8a6vpn5sP1miwwLOajE/uMgSfiKKtLyK9Bjz5R8WQholPJvIL8Q5VzqLWi
         Z7gtBKgGkMMgfc2GRLlkn6+mZnxqB2I0AAeg5q7cATx1WV9YVPKlkEOzSl98KUrrUnG4
         gAzE1wmK2NswL2xtr8/IxpHJhGvVPxDAZbFXZ+ZGe5GJ/0jktfEja3joiOFgBYbK4cgP
         csukWuk4IUPvh0x9abzFi+8CL40mFGeDoCXjI/iH9DK6VeWzOdHV397vyZ8xg3vITGZF
         5+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zi+iUdTui0eMYRh+bS6eQbXlcjJzEZc+EWZsqkgWXs0=;
        b=oEN6q6s39A1JL+b8mQmtgtG93Qls1S/yscLy4k3RZHPZwVW5iZz9zHllz2xXhuyKkx
         Z63z6ISiGeOT6fTJyTapA7aJomMHAyVdr5Rd6up6XcehfMotW3Wb06+ffTbk7NKNF2PD
         0unM/140U5SgjiRn7RGgbnx3JiaUUlQB9A5dMeU8x16KHhBXZD6a5CmuQ5PABBPdJ6op
         1AR04k8ODeOpBWqkI3M91mxc/gaND4MbMLkr+N/kGSF18MbQP7KV8aSVqBSxPD0+2PzP
         m2GqONJ88GJZrTMqd4S8pe2vxYwaOTmEb3a5i2lnfGZolvbrQtR+73kQTFKPyfEjgQi8
         myVw==
X-Gm-Message-State: AFqh2kra5In3Rdyt0rKvTvEecmM2Q0qKDZx9jbWp77oh56TGpNX5c0C/
        ADkF6WYoo1cSjN/QySy1e6f+CJ+mk+gp0giwWSJQfA==
X-Google-Smtp-Source: AMrXdXv/iZkG4aEOY0tAm5Pe8RQpzhFSGNbe/VHOdBJlj8n/e3z2TK0jIc/xskxrsvKD/lF81sJaEsZr/n0FCDbXJp8=
X-Received: by 2002:a63:a5e:0:b0:4b4:e491:c331 with SMTP id
 z30-20020a630a5e000000b004b4e491c331mr630573pgk.19.1674497071212; Mon, 23 Jan
 2023 10:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
In-Reply-To: <Y6H4zqr8bObRFE1g@linutronix.de>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Mon, 23 Jan 2023 10:04:20 -0800
Message-ID: <CAFzL-7upCjPPyB-9tHf4E4=M+GFot2fnH9t7M5x9cKikUMxB+w@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>,
        Glenn Elliott <glenn@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:03 AM bigeasy@linutronix.de
<bigeasy@linutronix.de> wrote:
>
> On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> > Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.
>
> Thanks for the ping. I did see the initial email and I didn't get to it
> yet. I need to re-test, confirm and then apply.
> The ktimer patch is not in v5.15 and this is currently the latest one
> maintained by the stable team. I don't know which one will be the
> following LTS kernel but this one needs to have this addressed. The
> v5.19 is not receiving any updates.
> Given the current timing, I will look into this in January.
>
> > Regards,
> > Junxiao
>
> Sebastian

Any further thoughts about Junxiao Chang's patch?    We backported
ktimer patches from Sebastian and Frederic to 5.15 and would like this
fix  it is sensible.

Thanks,
Alison Chaiken
Aurora Innovation
