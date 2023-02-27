Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536D66A3F09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjB0KBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjB0KBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:01:41 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391AC1E299
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:01:40 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id s8so3648641ilv.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjSKiZHKJ5T04w9B2upLy8IC+MrE7la7MpUEWGjZE4w=;
        b=Eagzuw893kj/fz52E8xza+xhv21D+E4wgZBNXA3XCQpuuX/g+8gcJnqoGa2BHyOlVQ
         x5rmZbCEJPj8DjktDmbL+fgIVjTqVEzee1MjekaeUu6t69lUmD0d3dFCP5Z6Z0hlPOOa
         8L3duVEMeaxCvN6Ypsh9LYOwGwALKl+o9unACocIZeJQizaWqVudcuqURkIpy3znZuAM
         8hug6z46ayjgz9yVV/1K9YOs2OBWxAxNXGJBTJRFiUgQ+hYH4A+zvmQy4qK6FQOmfJgu
         Pu7F1FCzQ7t3QLCDjWPPnskf0+33cdKqFwhY94OPPRJ2drQNw9aW/4sTcnCHqsdGWi4v
         ihoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjSKiZHKJ5T04w9B2upLy8IC+MrE7la7MpUEWGjZE4w=;
        b=aLL1/by4X15mKQ512acChL296Q8Ua0FM2d6yElbU8Mg6bi3j+B15CH0+FjV9+9g15F
         MxwWmlrla+6WRa1wJi6PqSeZB28YbOx0ZcIh9zMWvXyCaQSQA/uA9QlzYTsQg0nipUdR
         UpxZP8GigchM3c+g1Ktz/3Fw5Mloci8+BtrWmnFMNAe73V3rRP6ZkyzBdba/s+ZjjKaL
         zOHa9orIx8QgTpTW9t+gjTbfrjf97/B2x00VzXVwvPRVYw1GmgLk+/VNKgSRZRDzMuGn
         BlNUOFveC9maMyPAhhopel1WY67x6Ie9AwzWnlhJNjQOVEZUCmGfdPhvWMwWBMebsmo4
         9DGQ==
X-Gm-Message-State: AO0yUKUarcnE4QLWsmiQ46sRJNsv8w5DSCU2SOJvmvaSQb8TIIVcenwn
        ICOe3qcyYur7FqtrSu5Qte6BYW0dxGtJ2ZwqQ2WWZ3laHmYO8Ib+osI=
X-Google-Smtp-Source: AK7set9xv4jdStzzQ7RhuKXpAtjkmh74ju4jd85phKJTuBHikJWfagtZlc5gbmWjqJ8nrA5+rLiqF+xtjED+6OZ/WNE=
X-Received: by 2002:a92:c5a1:0:b0:314:e9b:d58f with SMTP id
 r1-20020a92c5a1000000b003140e9bd58fmr7657292ilt.2.1677492099155; Mon, 27 Feb
 2023 02:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20230226201730.515449-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230226201730.515449-1-aleksandr.mikhalitsyn@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 27 Feb 2023 11:01:27 +0100
Message-ID: <CANn89iKtiwF6AwBT3CgMUVvtA7pGON5O-aOUG4aQSSgmxDMVbg@mail.gmail.com>
Subject: Re: [PATCH net-next] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
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

On Sun, Feb 26, 2023 at 9:17=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Currently, we set MSG_CTRUNC flag is we have no
> msg_control buffer provided and SO_PASSCRED is set
> or if we have pending SCM_RIGHTS.
>
> For some reason we have no corresponding check for
> SO_PASSSEC.

Can you describe what side effects this patch has ?

I think it could break some applications, who might not be able to
recover from MSG_CTRUNC in this case.
This should be documented, in order to avoid a future revert.

In any case, net-next is currently closed.
