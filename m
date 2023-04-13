Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B36E096A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDMIyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjDMIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9B983F0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681376006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/ayCgB4BHYU53MBuC5QPpg8jAmYuyUSUdqQ4gE9310=;
        b=Hpx6egsehlPVu51pUPBpm3A3Hfy5+srV08/4kCKf28oqCwtIbxnMEtzI8+40vHgZRpj5OC
        7ysDAtUza+U3MDPzZ82cydivOEsENPvIjaa+tZUNosH7c+sAqMgz0XOw2J34cFSZW9Rzco
        yqEr8PV8as2ZN69fIPUldXYWM6N4lZs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-TIGlEQN5OGarYG_2lU8law-1; Thu, 13 Apr 2023 04:53:25 -0400
X-MC-Unique: TIGlEQN5OGarYG_2lU8law-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74a904f38f3so94683585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376005; x=1683968005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/ayCgB4BHYU53MBuC5QPpg8jAmYuyUSUdqQ4gE9310=;
        b=RsvDG5mR7appgwLNC8zhnb6KceAgpRejjGwwj2fGkU66ZkL+McgG1/BzPIxV9yFYXv
         4lSGwSJkC/xaKXvDmnLBk9fNgdBrj5kgS7hJMSgFfwIkc+sme7SoMEpIySuiTRO4TQ4I
         r5jJBPZOycFRdVZzS6UPfrEYGBdXZq5TyPyfeluyzHH2jox6wWBoN800AKfmfD3+W9BW
         4UYP5/3bUw9KB9TwvDN6OjhWaGaTTPEYhNRulpGLn9dL1BCA7YrZVNzsE7OFIZRqXS82
         quZZ8M0w3swPNp3fJeEXuHfGcTr9GUfzZrQGg7s52qzu1ke2gng1n8OfueuD2BYyrNqq
         aWJA==
X-Gm-Message-State: AAQBX9c1AF3KZCgLDtH8Q6ieF9ynyzDI39HCdAMcWHvBHUr9htpESVhF
        ZcfTLJGFtml+VzEcGLwPUf9Tf5JZApCfyXcMz9iKewGzDo5yxJjAsRnSMVf8esoR76McXSsJTlA
        DhVplvQ8ONZuzWhghnAjHbGZj
X-Received: by 2002:a05:6214:529b:b0:5ef:4436:b96f with SMTP id kj27-20020a056214529b00b005ef4436b96fmr1909093qvb.5.1681376004944;
        Thu, 13 Apr 2023 01:53:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIf8zkZ3pMxXqMlJegZ1MjfzBxJ1bTiipmj3lFDsmkwp8f+S7BMxMGzVhmg+UPdwJAGffBQg==
X-Received: by 2002:a05:6214:529b:b0:5ef:4436:b96f with SMTP id kj27-20020a056214529b00b005ef4436b96fmr1909070qvb.5.1681376004697;
        Thu, 13 Apr 2023 01:53:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-183.dyn.eolo.it. [146.241.232.183])
        by smtp.gmail.com with ESMTPSA id lb6-20020a056214318600b005e16003edc9sm280517qvb.104.2023.04.13.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:53:24 -0700 (PDT)
Message-ID: <9a56509f598e4c65584ceb8b331b784d6ccdafda.camel@redhat.com>
Subject: Re: [net-next Patch v9 0/6] octeontx2-pf: HTB offload support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, willemdebruijn.kernel@gmail.com,
        andrew@lunn.ch, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com,
        naveenm@marvell.com, edumazet@google.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, maxtram95@gmail.com,
        corbet@lwn.net
Date:   Thu, 13 Apr 2023 10:53:20 +0200
In-Reply-To: <20230412182756.6b1d28c6@kernel.org>
References: <20230411090359.5134-1-hkelam@marvell.com>
         <20230412182756.6b1d28c6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-12 at 18:27 -0700, Jakub Kicinski wrote:
> On Tue, 11 Apr 2023 14:33:53 +0530 Hariprasad Kelam wrote:
> > octeontx2 silicon and CN10K transmit interface consists of five
> > transmit levels starting from MDQ, TL4 to TL1. Once packets are
> > submitted to MDQ, hardware picks all active MDQs using strict
> > priority, and MDQs having the same priority level are chosen using
> > round robin. Each packet will traverse MDQ, TL4 to TL1 levels.
> > Each level contains an array of queues to support scheduling and
> > shaping.
>=20
>=20
> Looks like Jake's comments from v7 apply.

Just to be more verbose, the above means clarifying the commit message
for patch 4/6 and try factor into separate helpers some code of
function __otx2_qos_txschq_cfg() in patch 6/6.

Thanks,

Paolo

