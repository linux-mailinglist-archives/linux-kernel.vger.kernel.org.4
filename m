Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24F62BAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiKPLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbiKPLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:08:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155305289C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:54:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668596076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwogQg4RY0UhxtFrKFf6UzwXviWVQCEE9KejmIIuHqE=;
        b=CBYdkqt/4TiJz6Kdgc75MiIA8BbtfFAnCdylA2ASfJnM5tC0dovDGOFmlCFY/r/laPuYij
        2KkSOonnzeI2HOIwwWrkUN8SkJQIFZC/fPr6NC5O6gSpRgRbzgJpzaQ9uCx8LygaWQi2F5
        QdZGTazusNzho4jKELHvuDNm02O9UQ9DzVjIfIR/tFQ3yVlvnhN9ulaC7Q4rQweS/6ANS3
        lNjfg7Ay8vh26+qwZxTpZKjNuuqIoBpc8bnqF+8K4h0odK8iXRnet2VG9oCHp4UAe9j5sU
        /Gjdug9ZZvR7mfw3MAk372UThDxVSOImg/jclZL7Y65nAq0h7zQTOvaF8savCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668596076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwogQg4RY0UhxtFrKFf6UzwXviWVQCEE9KejmIIuHqE=;
        b=RfG0xiamJWgNPnV1LgDAj927Kq+9jSbJgYO/V9fyJHT7PmNHi1fgY2RCLSTWoQWKUo3JBt
        7K7pvFFlwb/jAiBQ==
To:     Angus Chen <angus.chen@jaguarmicro.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: IRQ affinity problem from virtio_blk
In-Reply-To: <TY2PR06MB34248DB15CBBDA7624DAFAE185079@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
 <TY2PR06MB34248DB15CBBDA7624DAFAE185079@TY2PR06MB3424.apcprd06.prod.outlook.com>
Date:   Wed, 16 Nov 2022 11:54:35 +0100
Message-ID: <87iljfqidw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2022 at 00:46, Angus Chen wrote:
>> On Wed, Nov 16 2022 at 00:04, Thomas Gleixner wrote:
>> >>> But then it also has another 79 vectors put aside for the other queues,
> en,it not the truth,in fact ,I just has one queue for one virtio_blk.

Which does not matter. See my reply to Michael. It's ONE vector per CPU
and block device.

> Nov 14 11:48:45 localhost kernel: virtio_blk virtio181: 1/0/0 default/read/poll queues
> Nov 14 11:48:45 localhost kernel: virtio_blk virtio181: [vdpr] 20480 512-byte logical blocks (10.5 MB/10.0 MiB)
> Nov 14 11:48:46 localhost kernel: virtio-pci 0000:37:16.4: enabling device (0000 -> 0002)
> Nov 14 11:48:46 localhost kernel: virtio-pci 0000:37:16.4: virtio_pci: leaving for legacy driver
> Nov 14 11:48:46 localhost kernel: virtio_blk virtio182: 1/0/0 default/read/poll queues---------the virtio182 means index 182.
> Nov 14 11:48:46 localhost kernel: vp_find_vqs_msix return err=-28-----------------------------the first time we get 'no space' error from irq subsystem. 

That's close to 200 virtio devices and the vector space is exhausted.
Works as expected.

Interrupt vectors are a limited resource on x86 and not only on x86. Not
any different from any other resource.

Thanks,

        tglx







