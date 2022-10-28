Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8147611762
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJ1QT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJ1QTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:19:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C825C59
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:19:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d123so230594iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xW0qy0QSAw0ACVX00MvHC2+VGmGGDq6tD3ZEfCdUDKs=;
        b=SsihEPHu6Fm4BB4DYOwzRg+VLMAxJA/lkC7J4rNqva58u6HwkxASdJUF50PATfUHV+
         owjMfX16oNLEWJgCpCKqoa7osqVOWSdy8N5OSXb6hCrPvV/xUPkf5dmWBXWstZh7RJll
         NlHmfcw7VLKEL0vRPR2ziuNZiveLDIX1gdEu2KihPXFxnKtHJQlkJxRWUgAK4RlGUJ6s
         rEs34gVeIj6xzD2uBQ2h0hqLVU0wb+6wTtD6vgMr6Bw4cfe/0XDJIeKVcXOkPkztNVqV
         ZpDkyg5dl5tnC6DA0NXXeK+t414cdMDD21imhRAVVbzP5ZzwoJcrLWKndZcxL1hAW+L/
         g7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xW0qy0QSAw0ACVX00MvHC2+VGmGGDq6tD3ZEfCdUDKs=;
        b=vLu+D1rNC32US0c7Nit+a1phhuKkoMOQ080zE2KN15Ns3wVGeHHx6qbmOlNBrgon35
         HvIG0cX4bhChLvuy2KGXl+5gxpsFz9PiAlx9PTYQ98fw1oY2W4MA01EaZPmNWtGKuNRW
         zkxgTzJGSavlE7x+/T0TrQ9FpEDtlSzm9rBEhmld/H2Ma4Qxg0i0F26HIAb/ijUfCt+U
         /N2CRE0DkKOY5hBpwpGKCz/jx3xRM9BcxLC7+m5e01VoJBcyE+85v6oODe7nX83wF/MH
         A3nvlS9lHv9hOtUqY6quOqkjCM0x41HDke6pXFYWC9lHuPFocwVWnx6kVYYoaJx01FS6
         1TQw==
X-Gm-Message-State: ACrzQf0UVQRpcRFH0NnBlWnK1IN5nfx9PA2bUNHB7l12uGjavtNaDNOH
        UqHoXK1k1yKxPzLRZowNn8nYLwiJyFM20JJ4xK3Eug==
X-Google-Smtp-Source: AMsMyM55sXUTfO66GI5WCzKQ9qDzpXG7NjVFhovcKJOiWVM5GqyJ3BII1VIKyWwSQCgeFeEi1KMotEd6tgsiNmqCH9g=
X-Received: by 2002:a05:6638:381c:b0:364:6e0:4e98 with SMTP id
 i28-20020a056638381c00b0036406e04e98mr128076jav.71.1666973944034; Fri, 28 Oct
 2022 09:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <CAKfTPtBJy4SdbYUNHFn2ZXEO_pnaMPYibfjXWNBnXy49P2h78Q@mail.gmail.com> <Y1vvPBw4xB7m23wY@e120937-lin>
In-Reply-To: <Y1vvPBw4xB7m23wY@e120937-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Oct 2022 18:18:52 +0200
Message-ID: <CAKfTPtAfuqtCee7f4bREsLqb5KJcLWw1Y=-0Y+2t+3XfX_YctQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 at 17:04, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Fri, Oct 28, 2022 at 04:40:02PM +0200, Vincent Guittot wrote:
> > On Wed, 19 Oct 2022 at 22:46, Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >
> > > Hi all,
> > >
>
> Hi Vincent,
>
> > > This series aims to introduce a new SCMI unified userspace interface meant
> > > to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
> > > from the perspective of the OSPM agent (non-secure world only ...)
> > >

[ snip]

> > Hi Cristian,
> >
> > I have tested your series with an optee message transport layer and
> > been able to send raw messages to the scmi server PTA
> >
> > FWIW
> >
> > Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
>
> Thanks a lot for your test and feedback !
>
> ... but I was going to reply to this saying that I spotted another issue
> with the current SCMI Raw implementation (NOT related to optee/smc) so
> that I'll post a V5 next week :P
>
> Anyway, the issue is much related to the debugfs root used by SCMI Raw,
> i.e.:
>
>         /sys/kernel/debug/scmi_raw/
>
> ..this works fine unless you run it on a system sporting multiple DT-defined
> server instances ...that is not officially supported but....ehm...a little
> bird told these system with multiple servers do exists :D

;-)

>
> In such a case the SCMI core stack is probed multiuple times and so it
> will try to register multiple debugfs Raw roots: there is no chanche to
> root the SCMI Raw entries at the same point clearly ... and then anyway
> there is the issue of recognizing which server is rooted where ... with
> the additional pain that a server CANNOT be recognized by querying...cause
> there is only one by teh spec with agentID ZERO ... in theory :D...
>
> So my tentaive solution for V5 would be:
>
> - change the Raw root debugfs as:
>
>         /sys/kernel/debug/scmi_raw/0/... (first server defined)
>
>         /sys/kernel/debug/scmi_raw/1/... (possible additional server(s)..)
>
> - expose the DT scmi-server root-node name of the server somewhere under
>   that debugfs root like:
>
>         ..../scmi_raw/0/transport_name -> 'scmi-mbx'
>
>         ..../scmi_raw/1/transport_name -> 'scmi-virtio'

I was about to say that you would display the server name but that
means that you have send a request to the server which probably
defeats the purpose of the raw mode

>
>   so that if you know HOW you have configured your own system in the DT
>   (maybe multiple servers with different kind of transports ?), you can
>   easily select programmatically which one is which, and so decide
>   which Raw debugfs fs to use...
>
> ... I plan to leave the SCMI ACS suite use by default the first system
> rooted at /sys/kernel/debug/scmi_raw/0/...maybe adding a commandline
> option to choose an alternative path for SCMI Raw.
>
> Does all of this sound reasonable ?

Yes, adding an index looks good to me.

As we are there, should we consider adding a per channel entry in the
tree when there are several channels shared with the same server ?

Vincent

>
> Thanks,
> Cristian
>
