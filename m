Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087374B474
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGGPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:40:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6EB2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688744379; x=1689349179; i=efault@gmx.de;
 bh=ylP9+ZNDPQYbfTTId9obf9+rw4X1x3mXi09x7g9dYNs=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=WCnxCyh96RU6pF7u97rwFX4JGKeRa0E5DfXpWoQZcFdXtRWaiA0Bb8Qj1CdGSLqfPqv3z3a
 JBa6g7Luz9IwiLBrCwLNyjyPgi5yeAp0Lp14sri1Db0zmqaw33Oa4n9PVA2g+34+B67CXhBKj
 jLng0AOzpzESV3hE93GecizGjK5aoIBneY/TxijCOfLlgaEWbSey1bk49yV+bn9rZwYaOZoxd
 g5bxmieK8rmG0cg1JqQrzlSu7yit9gra+YnIa757FDQAxUP2rjUifh+RuEtnTa885l89ZBh/o
 Wpafe4aB5orypm7KJPwV5s10vYgHEDtBBq1G8H0F52aaAC8aY3UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1pYogZ2Clg-00lVFm; Fri, 07
 Jul 2023 17:39:39 +0200
Message-ID: <f4e839ac5ecb285b8a9d666f1a73e0a39b698864.camel@gmx.de>
Subject: Re: Fwd: Possible race in rt_mutex_adjust_prio_chain
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Henry Wu <triangletrap12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 07 Jul 2023 17:39:38 +0200
In-Reply-To: <20230707125942.GB2883469@hirez.programming.kicks-ass.net>
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
         <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
         <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
         <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
         <20230707125942.GB2883469@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eCtcbb9DASdA4l/kL+LDKIXXOpXcWwsb7tG7BoHQQEREjyn0op9
 CRXUUt5MidEqkmYjBtW8ZmOTfDOC5b0bMsbqqx1zFhywCZOoJNcd+P7YwdUr4V5HNC4cqAM
 eAR6ZzL0QnKShfYBexOVXmkcQdJ4HbZaPJxa9Uwpj5rMOpBTrhxP21ztD5N8pyupg2WTqSZ
 IAnRaIA3+tVnRUMp2svPg==
UI-OutboundReport: notjunk:1;M01:P0:FkJjkHtWmEY=;CW4UgzIDZvlNmuHjsCWn9qNbm/c
 n43YHQL2ytga9NRIVzxIzz+YhNgsN+xiN954qUC2pA1CI+XphSUTwj6nM96mrf/yCIGtDWmUR
 Jyc5BJqw/VhlSB8KeCG9qd1oDFi5qrT3RV/RG9lWXWnHE+CjMci9J/S/fLwl3RjfiLngwk7Vh
 XB35lFBX+dwKWcBe0+6sm7as9BxzSUY5RVniA2ZenRUiUY6aKAtsgBgN0yFPWuh5GYZ+sf2Wj
 3jwzaLX38mgL4jVfLnBbMPZyYzT1USoGRKYAdkxHPt/yu00IGJPzOv4NuZaKplWa1m/W6i/2G
 Ja6YW/lPAS7jVtc481pQFpiGibmS5xuCpwqNY5s1454G0UJQ9mhYjLS9wb8RUZaJWA9ckUUij
 Y6x8xAN6i7dSeSsBceWVzxFGcjflqNX+wYQl9VGg9KOyvexDYXB3zDG4oqEAv0WnVs5zxaJRz
 k4iA5hDJUG97QG39q5YaTA3IFDR9aLgfgnvkYS9+uqY73x5w/1sPP07Tuqs5g6hSYQkNaQ4c8
 EV+MYHpKrpGshxnFffDpbt2AFRtra4j0wVQvtwVyAZdBiu34u1O6MFN5XQOufo5V1AXP12iZy
 B4Sv+zkKJfLfuA4CoTimk8C3rmmyE4j2kw56iRrsvTgGDRzfRGfQSsPs5N11Szf0D+MOCUCkE
 m49MxdBpKDwIVx36aCitbROze+4cU6lV6PDm4HkRD4+IoZJqP/QA3K2/a5krcM8Cu/IzF2WPS
 OEgfQytbBgPgeDR3MhhtLONtHnppVLL6RY08aYFcmKRjaXT45nw6AMMwMqMDMi9SOUTJ5B4s1
 Iqii9nAs8PesGH0GdB6z3dXyQQYAwRQtmCzH+BRt/MvNAUIUauuOz9RV6t0LB4LMvA6KYxCE/
 Qt+QpXVGfOV2LY06Hq1nZvVtaMysjwoVI6lQRNciAmbZUcwrWYoKmqn3WLFCd+TTuz3KAstSS
 SV1VsXUkxBbO5wBNHss7I5foFU0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 14:59 +0200, Peter Zijlstra wrote:
>
> The below implements this duplication and seems to not insta-crash.

RT bits of ww_mutex.h needed tree_entry -> tree.entry.  Modulo that, RT
seems content.

	-Mike
