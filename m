Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF26C72A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCWVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:54:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D3113C9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:54:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so689599edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679608461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwF4PjfX50G0tO1s1nkfZf9mTnmPVFCblQ+X/mkUZqQ=;
        b=YKRqrgUtGQB786BzEPoTerZ2BnxE1dpN1C7HVa2Y20hRAztcSIB+NS6haxgn7C6uKe
         T7Nhp75A0sbsrZ6adfaVbee+q7B0dtimbGW0106aW+plgIyT/JMv9TF9iKDqJQ9LmitB
         Ss+cRcEjt6a61jKggDJoMNHf+MpdsJyz8JmB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679608461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwF4PjfX50G0tO1s1nkfZf9mTnmPVFCblQ+X/mkUZqQ=;
        b=NOxXlFaaOxZoU8RrMJTI8tujX9YbroL13FBRE3kZZ90Aye95oigX8/xaZ4wYazUsXt
         oGXuZWNpAbgOcARnst2tyAz9Yuiakyk4SrjVD5lFvF7MLNuxNsuF6YML5AkHXaNIuYXx
         qp1SVamS0+OPZJin38cfuhD2nEtda5epJvGOWsNpWj5QZlBUSv4ZbWYklND0WtKUo4Yk
         MIjJba3lGDSBkuH3Zmt8jtIV7JBbLUiJcRL/gzHXu+i1wvM/GHbQtfnzPLElPenQDP/n
         0FnRaPUg6xdT/9lef8f9ziI0sTHLYbWKfnBuvRx8gfu+VR9Wd3BJ08Nj+AHojztp+m2Y
         elTw==
X-Gm-Message-State: AAQBX9fQjMFLzLnaJYatjY/Hm7mbqAuQF08C02fJrGN2x2hXk7nSeRCz
        QtQ2Sb6LU1KuMkKUfvtN/PRGW3pDGjjYAWln451s3Q==
X-Google-Smtp-Source: AKy350bOBh+cZIQexMpLumT135JtaxgIW3+HNfmp7N/jqbsHK6tkW+H0oM9ASiV67SGFkyEubgzVBw==
X-Received: by 2002:a17:906:3b15:b0:84d:4e4f:1f85 with SMTP id g21-20020a1709063b1500b0084d4e4f1f85mr480284ejf.59.1679608461610;
        Thu, 23 Mar 2023 14:54:21 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709060ad800b0092ffc83cc27sm9229442ejf.5.2023.03.23.14.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 14:54:20 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id cn12so776552edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:54:20 -0700 (PDT)
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr252006ejb.15.1679608460276; Thu, 23 Mar
 2023 14:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230323102649.764958589@linutronix.de> <20230323102800.215027837@linutronix.de>
In-Reply-To: <20230323102800.215027837@linutronix.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 23 Mar 2023 14:54:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVN+bMsYjTWQZehtRJNifGDuoMsgQg8789aZ9QT1pfjw@mail.gmail.com>
Message-ID: <CAHk-=wiVN+bMsYjTWQZehtRJNifGDuoMsgQg8789aZ9QT1pfjw@mail.gmail.com>
Subject: Re: [patch V3 4/4] net: dst: Switch to rcuref_t reference counting
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Wangyang Guo <wangyang.guo@intel.com>,
        Arjan van De Ven <arjan@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 1:55=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> V3: Rename the refcount member to __rcuref (Linus)

Thanks. LGTM,

                 Linus
