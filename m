Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E36C7693
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCXEdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXEdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:33:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA328236;
        Thu, 23 Mar 2023 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679632370; i=efault@gmx.de;
        bh=s62ipTxFk/ZZQc6RjTGcI/o+EXwklTwQu5a2mqXeOfk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=h2HJpbSJI1uZY7AT3aoSxJH7fTN8ZanDumIlGtbSM6uZofhaDMF/Pk6zVz3tC21lL
         B3B7YBU+JILY6Ga0ljLK5MddXroEfF89/1V604wLtAWgUEI5EhL/NFZmdISpMLFYO9
         3xBlbUvIs3cOkEJ3XHF702+v9z906BVz+4VhD+9uu1jGEFt73UMfEftO5lGIX8YzPF
         1O+72nZWcL2+BeBy8lnNDbJGE87cLyht1S/EvIhNYZxTUuNaEzM2leZn6+B/CTGjS4
         qejdKZiKF2I7ravVGAs3g6triKCxtvoohRS0MED64SEOqW6Q0J4tPXS3OQwYrjoTc4
         XStXpdG1aEsGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.216.185]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1qbUu026za-014nAB; Fri, 24
 Mar 2023 05:32:50 +0100
Message-ID: <b990dfaa093d8a3b219a789c7ebf972bf001772b.camel@gmx.de>
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
From:   Mike Galbraith <efault@gmx.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 24 Mar 2023 05:32:49 +0100
In-Reply-To: <20230324040750.GE3271889@google.com>
References: <20230323161830.jFbWCosd@linutronix.de>
         <20230324040750.GE3271889@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L9A+GUxMdTHolQU8gpnn7tz6hTj0+abhDDF3oYvBKDfG5kaRmLO
 wEuGjeLHbKBJM6WSOOuJ4lqlnbzmA9UxnAnofbxQogYwII7YdQ6wrq5E+jBuWCBK0MNtn5d
 1PCF2Kfcigxk5PnEcVKxBAjQN435SgMvI2U1n4bdixtGrJi/WU9SxHbirSucI2Il06pGNyH
 LkgP+SrjInHKRW0MH4J7Q==
UI-OutboundReport: notjunk:1;M01:P0:dWl9TWImTj0=;li7vaI+rE2Iu1du5Ae1oUQQq9uN
 X0F/AXoD9QTSkr1LOHZmGiCVgwHMjc+jTUT1JkDR8CI6697eqtLqT2P7bIa4xgufe6VSfZlT+
 ezOiI34S7gqt0j1nA+q+uKTlpi/hT1MmFSiIiw2CUHatqxUeguQr4QLk82Pef5arTMbBq+I12
 hEC2SidY4OD451dkdl1haWxsLbsavyjf3CPJmUADrJFkfa7ZEW6drjOlNjqan9LbEZXPSLVg7
 u7YsdANvdIbVoo3n9EmdHmkF7KtZ4lNS9Tx78xY2RJwIIKMC92HpOkO91upAnoT7zfxj9DKVf
 15cDf6tNNtrpZg3m/JN6F2ImP50lyzsXCYeUcI2864zp0E5/qFK82Lr2tSHp16mM781x9QlsJ
 MA0e0/LeSERfl4X4qbTVSWGLLjTwi024iopGDIhxb6gjx2LGCMe9D+50CsDllt4wOFz23TCvT
 S0tUE5Pk4wBgoiKAhZb0v/tLA6t+aay3oUgCryv7l9O3GTY3meT6hfjk9yAElTgpu5ozCmuKN
 HEdl1PIbrMq/7GO17VIoRxKO6Q0oxrMKRWvqMbM24S7lhr1MhUKdnlTXzyouF19RwemK4zT88
 7ijO5CeeJSRnrkI+k44ACjouXLwJCQAhgE9xh65xblX7qFqYmsRtJdRXsB1I0Tyv0R/F7hmq/
 Pu1tIM7FLLrJlb1B+KSXqGyaAy+BstGalHUkH+4zKtFCnlus8uo0yvm0STF7cy3i/90nCj7mA
 /BEGomfRNRrE5r3YdzzYjDM1/r8jjKF4jeK/yN5dcbVbdykGChoTzxazp14Y7J4AsXvaA+wfF
 ypj6ZksSXn1So21ezhmkEdtOzXVNUpCZnrFj3/W5Ly0u+/fKcOILy7NJSAzZYoithOxS/NrUn
 MTc4xn2+gmem12tgTGVdO3rxGQwNkNBNxnQZXcrRw0B6ZzgGOK30v2/NWMd8Dhxf9wd0gkDS1
 TJ0dNYRi+gKTEb7j5808T4ZtIRI=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-24 at 13:07 +0900, Sergey Senozhatsky wrote:
> On (23/03/23 17:18), Sebastian Andrzej Siewior wrote:
> > Mike most likely stumbled upon it while running LTP.
>
> Yeah, I'm curious if anyone uses zram in preempt-rt systems. I don't
> mind this patch but would be nice to add new code when it solves some
> real problems. Maybe `depend on !PREEMPT_RT` can be a better option.

Patchlet's job here is only obese config RT vs !RT testing.  It can
always move back into local_patches, it won't be lonely ;-)

	-Mike
