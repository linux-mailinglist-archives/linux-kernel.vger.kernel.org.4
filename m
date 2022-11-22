Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2F633AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKVLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiKVLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B342B247
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669114797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZ15QZfNx5TZYA9TqYEZfhCeGYi/zDR+lUcnamDPADo=;
        b=aKpPz009NXNfknwon4Yo1CUk7CMKjhfKi6bfmDN2JeHvo5c6qO5bpEpOO+jtrUsDp45jQO
        dXKViOD7R6+jpQUsp9H3/RHS0Pg1lVm+3n5ptoHLD3Gpw0u22FkeW3wk1feNAFhSBgxwMx
        9GtNlN0D2fXJruhNELMkG/JlIpHLgo0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-84DGk9mbNeuuAktBUZkjIg-1; Tue, 22 Nov 2022 05:59:56 -0500
X-MC-Unique: 84DGk9mbNeuuAktBUZkjIg-1
Received: by mail-qv1-f71.google.com with SMTP id h13-20020a0ceecd000000b004c6964dc952so10619094qvs.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ15QZfNx5TZYA9TqYEZfhCeGYi/zDR+lUcnamDPADo=;
        b=pcqd6upleE/e9JnTE1eWkV6blo0E2kq5cpwP1Ku/ICo5vviY9gp7/PS4y8NZ2rHTsI
         Y1BxpfGUwjB9Wnj8T8MfQ8jAOlMTFRXMYZMRLFWrbMnzwTNeeJW0oWN6qCxTHCNYk1MC
         9tcK9KGjEks5AUKYmsWsCamCsGFjLLK6y3iHiwM0Z7mP4rsZhCdui1zBU5c1tXgZmS3z
         GoZhjWFfTBKajiHiOa7wpcXoGI9KWjpzHTGqk5y6W24LCaKp1JLJfgsaQBHPhjS8LA5t
         8MLNIWEvtBvkrxuqcnCFurXqgpJr8sY0MOyNUmDLLWl5b42G8CsVpHQho1jJoOROS7TA
         ewrg==
X-Gm-Message-State: ANoB5pkqGcneCyCJOP/lopIMncvOABnbBhRvErfWyPF6MXfBvAvKpZ+9
        2Tc2Hkpjwy6ci1l+7VDs6ALozLmdgoIONLkEflB/yBwYP5hTdtaTVbGAvvkMKnG9FuXKB1oS2UO
        GuHK81c4scWKbF6DqnkT2lYSB
X-Received: by 2002:a05:620a:958:b0:6ea:ba87:4385 with SMTP id w24-20020a05620a095800b006eaba874385mr19918158qkw.128.1669114795723;
        Tue, 22 Nov 2022 02:59:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf52FolY0Qq1mpykLuYR5naBZsmnjsJzEN2VLZ3Pg7pc07aUk3yDmUUlVVsqqzUGSpXC8TDzIw==
X-Received: by 2002:a05:620a:958:b0:6ea:ba87:4385 with SMTP id w24-20020a05620a095800b006eaba874385mr19918144qkw.128.1669114795478;
        Tue, 22 Nov 2022 02:59:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006bbf85cad0fsm10383626qkp.20.2022.11.22.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:59:54 -0800 (PST)
Message-ID: <38fbc36783d583f805f30fb3a55a8a87f67b59ac.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] bonding: fix link recovery in mode 2 when
 updelay is nonzero
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jonathan Toppins <jtoppins@redhat.com>, netdev@vger.kernel.org,
        Jay Vosburgh <j.vosburgh@gmail.com>
Cc:     Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 11:59:51 +0100
In-Reply-To: <cb89b92af89973ee049a696c362b4a2abfdd9b82.1668800711.git.jtoppins@redhat.com>
References: <cover.1668800711.git.jtoppins@redhat.com>
         <cb89b92af89973ee049a696c362b4a2abfdd9b82.1668800711.git.jtoppins@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2022-11-18 at 15:30 -0500, Jonathan Toppins wrote:
> Before this change when a bond in mode 2 lost link, all of its slaves
> lost link, the bonding device would never recover even after the
> expiration of updelay. This change removes the updelay when the bond
> currently has no usable links. Conforming to bonding.txt section 13.1
> paragraph 4.
> 
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>

Why are you targeting net-next? This looks like something suitable to
the -net tree to me. If, so could you please include a Fixes tag?

Note that we can add new self-tests even via the -net tree.

Thanks,

Paolo

