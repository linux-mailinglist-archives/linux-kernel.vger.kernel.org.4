Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12F46BA351
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCNXFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCNXEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AEE2311A;
        Tue, 14 Mar 2023 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678835075; i=w_armin@gmx.de;
        bh=qaOYbVxlV4TC6mJdvMRjRW2d/YSuT6ZiZfALvgXQgqk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SWFhvhmhqKCnw4j74L7OMtr8P6pOzVf2QWZL4Uw12qc1hwDhVk9AokO2RJGUKzP5A
         Kj/wBkuV2O9rA4Lxcf6WuLOSVR8tPdz3gBke0GDjn1OrkeAgV0/KPztWn/b1nO8mmJ
         LFaW0x4ue/p/Weh8Sm+Qxpr8U86vkWGzihxgORntCFtn/XA6L+hOA8E2fyDzGaJx64
         zQ6GGyUcbu8fVgqDmCbUv91wHCDF9ve5Y6SgtBR1ZxCJxJkFjdubMyrlmpUOvhnsAB
         aip34K43x6nSz2uT94H5XTlQwemUgxYGNUxfBtTZU8ZPUC64KvZPASxuw05dAI8S96
         amXkrhh2e0ncg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1qRxD53W1t-00yzbd; Wed, 15
 Mar 2023 00:04:34 +0100
Subject: Re: [PATCH v2 0/4] ACPI: SBS: Fix various issues
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230225115144.31212-1-W_Armin@gmx.de>
 <d2660362-dc25-e75f-394b-1997bd062933@gmx.de>
 <CAJZ5v0itUSnsxgdvw39e+YZWe4jTHA1fLjw3HZSKHTkp+eLHwQ@mail.gmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <1de16fdb-e6e2-57eb-b074-cdd5473172ba@gmx.de>
Date:   Wed, 15 Mar 2023 00:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0itUSnsxgdvw39e+YZWe4jTHA1fLjw3HZSKHTkp+eLHwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:PiH94slGM/B90fh9qRyot6S8l670iWYh19wiqE2/7yVLpiigRzx
 aICjE/VCUFf81eybQKZrTAULCi5R/+tFMvhg77w/XyHHszlcZZW/Cx211FIvZo1D3gi1BlE
 K9noy8lwhGCHtN2beuE5u17DfuF04eEBGTK/WKmeG++wctvq2KlXEOrvmfO0KPZR2NGt1zv
 Je38pKmGoTv92mb0snWrQ==
UI-OutboundReport: notjunk:1;M01:P0:WUdxOSXju3w=;cz/ILUELcEXniplTcB/n4OvVfDO
 Hwvr1f2KHLeMr6HNSEpg4He7N1dLVriLCYgVi03/rnZHGABxHyYlPzbEMBH27AhOmbktphrk4
 BP3zxwY7PolbwEf74c++2YWS/XH2BDbMpiejqMAHWvMYLQBA6qNaLlQxMR6u/LLK1RTkNKHsC
 6HqOcM0l7dTgpI8VA2csY5DbnY2Ax5bg/07uBeF73s1rGqbnN7MCqT8u0vKRlMQUMb+8SsQDC
 HWU83spN3kFnJ7NiRTc2IEo6dyMOSOKvbNMaSHNfRZHs9Jhr4XxO3goGTDljEQpgQ00NHL3a2
 ybeQ32GorIH3Qq0NDJxTZNR0RzzTdUImocqQftCjfRU/gu4/DXlhJbN0re6S0JwoRZTo8NNNj
 N1wFEHxZY4I3znnGowLRY911YXTTT0AycvWD62SCHXP6QGSBzgbsZs4dyH1MP87Pc4DsfRH7b
 f6CuW484ptMWrXWM3SQ38fgajm8NBPn+5ppRIbaAxU23waq9jtFQKPqci+1iiu0R/Qkksk7/R
 t0A2sBG161mf287NXvm0fUrFLiPJJJbivoLaRnYao9fOob5UbTm6bpkESDrWdBcRExJi2OSRA
 UeCb7a7/aFOFbv212ZX1KpS6qKTmcrRDn0Mw8ZTg0rO7n8EGedXsqG5CzsmpgJQkcj9cCOc7v
 B9HayYQS/JZO4mTRqxwDB23eaBd/+a6Dt6v1HdTaq0y9XpuGml8r0CNa2c2y4pklaqAfQodFw
 dUdDp9I+1jZVtN0H020CbVjEpiRiNOzKI8BEi5ecXp1zZLqRdh9U+JCrOObNtrsR6SpKT4QsF
 xzOMaj7YSj+pXg4GavJ1e4bFzgiuvC5etmHAhptN7JHx386SVG46IPMSrgZDgGgZowxhQS9qR
 sWxI3EIpk1YW98n46bTX2PW+vbKxXDR8wPoz8d7J/y6k+kxinLCPp0EeTdCF7WKoFALM/jMBD
 dFv+7mTNyfrTJvbW3NRM4lKbbbw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.03.23 um 20:49 schrieb Rafael J. Wysocki:

> On Sun, Mar 12, 2023 at 6:15=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 25.02.23 um 12:51 schrieb Armin Wolf:
>>
>>> On my Acer Travelmate 4002WLMi, the system locks up upon
>>> suspend/shutdown. After a lot of research, it turned out
>>> that the sbs module was the culprit. The driver would not
>>> correctly mask out the value used to select a battery using
>>> the "Smart Battery Selector" (subset of the "Smart Battery Manager").
>>> This accidentally caused a invalid power source to be selected,
>>> which was automatically corrected by the selector. Upon
>>> notifing the host about the corrected power source, some batteries
>>> would be selected for re-reading, causing a endless loop.
>>> This would lead to some workqueues filling up, which caused the
>>> lockup upon suspend/shutdown.
>>>
>>> The first three patches fix a stacktrace on module removal caused
>>> by some locking issues. The last patch finally fixes the
>>> suspend/shutdown issues.
>>>
>>> As a side note: This was the first machine on which i installed Linux,
>>> to finally fixing this took ~5 years of tinkering.
>> What is the status of this patchset? Should i use a SRCU notifier chain
>> for the query notifiers? I would really like to see this getting fixed,
>> as it prevents me from using linux on this machine.
> I'm not entirely convinced about the query notifiers idea TBH.

I already thought about just flushing the query workqueue, but acpi_ec_rem=
ove_query_handler()
would still also remove query handlers installed to handle _Qxx methods. T=
his might cause errors,
as for example on the Acer Travelmate 4002WLMI, the SMBUS query handler (_=
Q20) resets the SMBUS
alert bit in case no EC SMBus driver is overriding it.
Is there any specific reason for your dislike of the query notifiers? I co=
uld turn them into
SRCU call chains to avoid performance issues.

Armin Wolf

