Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D469F0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBVJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBVJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:00:13 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3B34336
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:00:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o4so6958318wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9vJOv2XZwGpYFirkM009zoQWdWwQTOjVb2oJAYQGwo=;
        b=Eo5vM+hCRDJBSEmJ+QPv9yVdgMkYM/cghiKX41vvt1HS5nynqC6+InxaBlrWywTxjx
         RMWMCRt2nff0+nW9sTqPxFnJ+6FMaJz9MssyxpIyEvnAQ/bo6mdK64N3QzWGXFoBu7sq
         MFvySY5meFmg3CIvaJdvm0ca1vU2WlXA1aIcjI4ZhzBUoaBkM3dmeMvRIzBOqLole6vK
         0a7G8nH/T/zuwr7ET3QCBjvI/g3iRyIXc+OT6eoymF+wc1re+QuWPFiQbQWDrTC9pRrx
         OoMJE1cWYKXEl4wgA/X5IlY6ahn6wDERnoqNn/+Hzw0e2nyUkHySXPZ+2LwXm0uMPxIM
         Rtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9vJOv2XZwGpYFirkM009zoQWdWwQTOjVb2oJAYQGwo=;
        b=ECu5cFBxq6ERe3kO/TdXPeEBRPMkihJNYcsY2Vzz88uhsvXbqlxBZWglgcWi+tTu0W
         GLUCIw84kQCrgOIfJ7u0Tp/YKfXao5+ga47xkmwTCeRq85TAgZ+d835iEUe1mnjXDXxT
         X1fMhPYEYd9Dj44fifwT6lHu4wdEUg0tEnPTNrr/tyPDsYE/Yv+FOXmEoarLS8kJ83W7
         XxNOGW/0PzCvEDJRNiuIAwVtYui4JgVGLjxopP6agDHNua5xVsZIotnTxgUt516EQ0oZ
         VXbkrJHHM+fDC1gxWMTvspAT7TDxLD9m/w93E/gGx47wqbbuZPSb3GT50CyXwmGXPxXC
         oxtw==
X-Gm-Message-State: AO0yUKWmKamMPmqBjV1I3iQQrp6sdZsasnf4wRirWwSRffUPKXtAtzxo
        ha8nPV6kj8VQhtCRha13lsQb+qVUgjxJSKgFXr1YBg==
X-Google-Smtp-Source: AK7set8UrkuFxQR68e3GfSOOrZ8nXwBL+cQSSbfa95v8jURooZlcfKl55RpjZtim4zrusSBveob3wBPJdwtPZM/dJXM=
X-Received: by 2002:a5d:5251:0:b0:2c5:4c8e:70b4 with SMTP id
 k17-20020a5d5251000000b002c54c8e70b4mr835wrc.549.1677056410503; Wed, 22 Feb
 2023 01:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20230222062457.630849-1-hbh25y@gmail.com>
In-Reply-To: <20230222062457.630849-1-hbh25y@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 22 Feb 2023 09:59:58 +0100
Message-ID: <CANn89iLT+HZKi0JtQA7HtUnMKfDSWBbZ+jeLmCH9kq+-oVxatA@mail.gmail.com>
Subject: Re: [PATCH v2] net: dccp: delete redundant ackvec record in dccp_insert_options()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        gerrit@erg.abdn.ac.uk, ian.mcdonald@jandi.co.nz,
        dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 7:25=E2=80=AFAM Hangyu Hua <hbh25y@gmail.com> wrote=
:
>
> A useless record can be insert into av_records when dccp_insert_options()
> fails after dccp_insert_option_ackvec(). Repeated triggering may cause
> av_records to have a lot of useless record with the same avr_ack_seqno.

Do you have a repro for this bug ?
It is not clear if this can actually happen.
Presumably skb are sized so that they can hold all possible standard
DCCP options.
DCCP_MAX_OPT_LEN is 992 bytes.

Fact that your first patch was not even compiled is not giving us a good si=
gnal.
