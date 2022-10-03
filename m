Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BAC5F310F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJCNVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJCNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88EB3A145
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664803255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVXsJIBXalnx9DWAK2vGpTAO0XTeIS5m62mJRZPuaKk=;
        b=jAmnYn/C3wd6bR/Kcoqu4TyeC/LgaaauUk8XuVKPoehWRUXs2adEfK2dncC5UoS0/uQo3z
        pWvcBDmfrZTXwEy0/dH7lWcRI+L3hj7v38GawinNlo+KNTULiS8BtGDDj9ix/dV9nk0I2K
        EHR4COpCXUSxXqoFis2UyojvPwmCtJQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-j29jgjcwMIqaieM7IfYKuw-1; Mon, 03 Oct 2022 09:20:54 -0400
X-MC-Unique: j29jgjcwMIqaieM7IfYKuw-1
Received: by mail-wm1-f69.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so2885470wml.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 06:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=hVXsJIBXalnx9DWAK2vGpTAO0XTeIS5m62mJRZPuaKk=;
        b=0QTPOz6SfeA1QRKouWNBv6TKmn0++vMIJwDaD7aK9M2TguXTFx7h0hE1GCWpbyneT0
         cpAXWwmkD0GyslE7MaME8WLkM/z/zJw3YwhgmfJRggred8yMWqhg02ggIKOYelRvMUN1
         zZXBjPf1x4TLxBL4+Jvnj9D4zViQTBQxKZZhvkY3cIvHXJ5x4We63UHd/RSD8gv4XZLr
         ij86Ot35dWFbj+NyCZ+fXnAjgjBV2QIodINFP6oRxPdHJLZULOCpQvQi7cJt387IFYNa
         x+FcYNE/bp3AeUW0RGmD2MqfMsnxSIqUdo+DEnmh4R2L2kWaB+TcQic6Gfs3Gix2R+Jf
         j37w==
X-Gm-Message-State: ACrzQf2ZdZfJXkJssTRRp5POAErBFcEQ8/yNiho/Bd9ADPXsO4kAeRMb
        dF+L6NEsu5m2ZG+pTQyonX79SHzYaI+R5MWoSYIONCeIeomdLdshbd5W+LG0vrmb1qgarNsH9po
        /LLSvxcsU1Nc7vY7iPUZcRDzN
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13557963wrd.510.1664803253466;
        Mon, 03 Oct 2022 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yziT+A7H/8++Xkk8zqP5zDeXrH0j0Cz7+uAIJmoQRJ6TFWZ9Hd0AE6hLkuUVLVWF97tjM0g==
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13557945wrd.510.1664803253271;
        Mon, 03 Oct 2022 06:20:53 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022ccbc7efb5sm9968291wrb.73.2022.10.03.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:20:52 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
In-Reply-To: <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
References: <20220630223258.4144112-1-vschneid@redhat.com>
 <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
 <xhsmh35f68tz4.mognet@vschneid.remote.csb>
 <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
Date:   Mon, 03 Oct 2022 14:20:51 +0100
Message-ID: <xhsmho7ut2gcs.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 13/07/22 10:39, Andrew Morton wrote:
> On Tue, 12 Jul 2022 12:13:03 +0100 Valentin Schneider <vschneid@redhat.com> wrote:
>
>> On 12/07/22 10:47, Baoquan He wrote:
>> > Hi,
>> >
>> > This series looks good, has it been taken into any tree?
>> >
>>
>> I don't think so, briefly poked around git and haven't seen it anywhere.
>
> I'll stash it away for consideration after -rc1.

I've seen them in linux-next for a while, am I right in assuming they'll be
part of a 6.1 PR?

