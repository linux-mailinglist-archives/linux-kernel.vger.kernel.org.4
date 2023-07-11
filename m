Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84074E785
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGKGrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGKGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:47:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7391B134
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:47:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso8127563e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689058047; x=1691650047;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ADRu1k94Szm9V0evY8U5mOQEsmaGQsPDAea7XrGLJeI=;
        b=FFxn8NDbk1lxoec1Wakuv80G8tu8rb2Dtr9C84hZPr9TRy5ITcpxR1IYx1jC3HaM+h
         Kkj9lZr6D35Wzxo8fKA1jlL45BCp2upcrX/sZx4eGjzI7Z4hFUtekH6k/lSc/YfU5SR0
         RIHdrOZaW55YLsHy7XjpuUv+ce0tVhZUNf9l3hYhTk8qWjFxOP1vvWLpecllmXqa7WEB
         CZ52wuPGSRsWNH4GT+luUbWOHqQWN7sQNNiKNteyxY1po17tCWKtRm+pZ0hmV1ZZoH93
         9h5+4J9oncrBEr7UeAiVeQ64cgONZYt8Wr2cVDqHTrSqgW44rsfdMvLQnysoryNzIwcZ
         Avrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689058047; x=1691650047;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADRu1k94Szm9V0evY8U5mOQEsmaGQsPDAea7XrGLJeI=;
        b=YyHcc0wf3461Ys9UFkOTSgdPNQIxxfx0kmKYDl8OlgUxAHRleyEinLeiFZS6J1d5sv
         BI3MhV5M+CHjDJUGYCBx2LmSjJKuUQC9Ou1gWJkPNCrtAEihWvBfcUh2AC8G+eB0nI7X
         5wL4BAktRk9s0iRpAeedSYbS47Od7/A1k8psjy+ri2YedPCnqJ+1hqbvSnRR4VLu2C+R
         1Qt7fXvldrJ4q6sVOziiDfB4wKNyxszCdVQAUaVShE8b7p0O8hDwzB+MX6BIDs4sKIzI
         1kyfmoKeHjLSkG2WPBbK7rUFk0tt0V1p6aorTqK3YTSvNUiRJd/R79UCHjsIIZBwys/J
         sCrA==
X-Gm-Message-State: ABy/qLY5rsdfWazc4B8BaxXoO5ss22RVxDUlokdVGymsDDpXzKEwpFD4
        mGAy1KMloimkKHdmetVwN1niYsnQDKSMsvqea30=
X-Google-Smtp-Source: APBJJlHxhvIChcTAwsEU9f19qUxlQmDyBugZNnIlEsKQig5XHaBQ9lHr0WXdhjrIG6brgbIIGeXmbA==
X-Received: by 2002:ac2:4f06:0:b0:4f6:2a02:fc1a with SMTP id k6-20020ac24f06000000b004f62a02fc1amr12549137lfr.17.1689058046058;
        Mon, 10 Jul 2023 23:47:26 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id u22-20020ac243d6000000b004fbbf9e58bbsm192834lfl.126.2023.07.10.23.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 23:47:25 -0700 (PDT)
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Date:   Tue, 11 Jul 2023 08:23:40 +0200
In-reply-to: <ZKvQPAN9OkS3dZ4d@infradead.org>
Message-ID: <87a5w3ymff.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Jul 10, 2023 at 05:27:23PM +0800, Ming Lei wrote:
>> Yes, that is exactly what we are doing.
>> 
>> The added macros of UBLK_IO_OP_DRV_IN_START[END] are just for supporting
>> more ublk passthrough commands, and the motivation is for running
>> check(such as buffer direction) in two sides easily.
>> 
>> However, I think it is just fine to delay to add it until introducing
>> the 2nd ublk pt command.
>
> The concept of a passthrough command just doesn't make sense for an
> on the wire protocol.  It is a linux concept that distinguished between
> the Linux synthetic command like REQ_OP_READ/WRITE/DISCARD etc that are
> well defined and can be used by file systems and other consumers, and
> ways to pass through arbitrary blobs only known by the driver.

Yet most on-the-wire protocols for actual hardware does support this
some way or another. But I agree that for ublk it is probably not
needed. It would probably be easier to talk to the ublk daemon through
other means than passthrough in the block layer.

>
> Anything in a wire protocol needs to be very well defined in that
> protocol completely indpendent of what Linux concept it maps to.
> Especially as the Linux concepts can change, and fairly frequently do.

I somewhat agree in the sense that for consistency, we should either
move zone management commands to the DRV_OUT range OR move report_zones
out of this special range and just next to the zone management
operations. I like the latter option better, and I would love to see the
block layer do the same at some point. It feels backwards that
report_zones get special treatment all over the place.

Best regards,
Andreas
