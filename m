Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74526A55C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjB1J3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjB1J3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:29:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350E1F93E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677576439; i=efault@gmx.de;
        bh=Mh5OXMSCRV0PT//DYXLLeEM6V4UJ3AHM0CEdv900pNw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=sn9BexvsHZ72xYXVvcNU87u1v40xImpkmESQirCGjg6VeoXwI91aUgabv+JXb/LBY
         Uhl0oDBZXsILgwZ+NXPoszjVZxm0HZ3QSn7BMSAPPMu7A1oWhR/cPL5qspEFj56Ioe
         NbwGfuKk+OemWOUN6RqVEYzZJfF4MEgkRh2Y4CttJTxp6y1udBHtmFH/tM+xM4besR
         pd0rjNuiNu88CwZBhGSRcxVBwsnwsf0u34TOFFOTf8h0Y74KNDFVvOIBHhLWOBBBbz
         nDnQPkypwfumj2jq67atvvziXacwk6umYcbkhVfiHUH1NU62S27FHzd5VkivKEHy7I
         QUTVDeVpZ+3Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.60]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1oxKSs1wq9-00ZjtW; Tue, 28
 Feb 2023 10:27:19 +0100
Message-ID: <bdb1bd4d4be9cf565c8e7107c5d544c8c5963f8b.camel@gmx.de>
Subject: Re: [PATCH] sched: Fix rq nr_uninterruptible count
From:   Mike Galbraith <efault@gmx.de>
To:     zhenggy <zhenggy@chinatelecom.cn>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 28 Feb 2023 10:27:15 +0100
In-Reply-To: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
References: <9b271641-ea59-daa5-333c-1dd1f02cdb52@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zVskWmPqOGpMyjllhoJjIScqbc+ubsL2B7PfFeP7LWdUYaUSWfi
 lfMAlujaAxgdB50gjyoAJdvMMjzEjdktHYq5f6uku8P2xn7CH9399NFEYw/SqEjdMVE/UPk
 9KsEUkMwaTQLYEn8g8Lc7IiAs/lSZXf60/A1DlUXj6O/bf+vFZkMAvnzCn92iMH3gFHQgZj
 1VxJIVZvXzgeYm42rhVQw==
UI-OutboundReport: notjunk:1;M01:P0:6hecg5nb/II=;k47XY4aY9vmdP18OdsE5/LL4m4z
 dcm9X+iV/pZTSphuJ7recj0PTRCQkfTO+7fpHOBZaOyevhSC7qSu4c1Hr/pQ7m04+l74nM6+e
 41yOHSRuG2fsy8JB/OC8imRjDfXTCQzdO5DrUS8P76IuDiJxOB/kEV7GcL8U+ya45H9Q0N9Ob
 ppqrOt8fGhJcU9vpQsvPxeMAwpFPRKgDHvb8C/ImEuH9DZtxQDnJcvaqg3sRXlW2DJneiWcjL
 Xci45yfdXrDlqdpYxmOSjeFSxwmXo2mqclk+GzSNHRvjkgoI8IkZK6YK1XR93Gax7vcJF1lCN
 E/CJlJXvGEMloqv0hXBkKC8febCZ5mNhmm/1PfUjBuug5AL+l5VNXnZmxUI2Guh5Y77MIyMvz
 ZYACDC7bV4mWfPKgNWD/cclDEhLWZbrm1zAA+SJnxuwz4QJSvIvyJk2awrit+guA1DE0KTWMn
 LL4O1oJkPUXkF9sGuWK27E7gIAVUpxRkeLz57BVcA/8Q8G5eE9zrTr09AUfo9TtJCpN4davnk
 vms0VXf2edt+QuOys0481UFHJ1koCxkXrY9jyFgJ1+AAaZoCFoNIECVyn388m/A2Zpia8s5hL
 RtV1K1AXYy0fvFgEcgf/xBMb4FdLa+ZLuFc1GDkcJjNW8BECflWrreBJvJQvJKBBKiLn8ZzIS
 DLuLTHgtjiU7xzrjW4WfFIGtkKyH44KWIM1EP4GvHXZitxa7MEIkSPhF6GrO01rVwi15ArH4/
 vhZ+8cy2Qzdw9LJy0JzUlP/jMregrXj/r6ff7/+nMCcxG/mW8YNZ1gx0TIfzCk5DRUvLGi1Sa
 cGEpcdZL7/kYL++gaNj5ys9cbpAPfyHU4mB5oY+nWxfOt0qAaqDUayeDbVOuhmHVSW12OM7Fp
 cXJcfDeAGwDcKUHtBaxzZxitylYYP3AJo82vP5tfeoSoD4i3mY8W3c3yEW6Nwq1tpA5pS/aJA
 ryNzMA1/ovRQqcGnDHgQHqHvCP0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-28 at 15:08 +0800, zhenggy wrote:
> When an uninterrptable task is queue to a differect cpu as where
> it is dequeued, the rq nr_uninterruptible will be incorrent, so
> fix it.

That's intentional, see 47-52 of kernel/sched/loadavg.c.

	-Mike
