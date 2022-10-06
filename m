Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A05F65CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiJFMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJFMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECD186F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fBCThoMbVqy5DIvqrDtJnmNzodt16/xEZ4Fk12bjYcA=;
        b=huXng+vrT6bjDrSJP+lxFbw1NmIuueAAX146T+B5tDq0qWicAz/QYGLkuSGu1RM6CTyEJw
        ZK6JneDkV9tpbnkHQK+sy6GLDX/Z3S18yV0ySBNu7Fcyhx3J2CisJOYeEiuNncYxRlWbj4
        GRj1/JB8Etd7utEiEW6GZiATs1z8amI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-KVDtnUBdNDKcGURA_9Blcg-1; Thu, 06 Oct 2022 08:14:47 -0400
X-MC-Unique: KVDtnUBdNDKcGURA_9Blcg-1
Received: by mail-wm1-f71.google.com with SMTP id ay21-20020a05600c1e1500b003b45fd14b53so1713179wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBCThoMbVqy5DIvqrDtJnmNzodt16/xEZ4Fk12bjYcA=;
        b=Rbds2qpKYZuijx9QKwvKFBpp0naheV7PHC3EYHkkvfnRy0eDpmQpX7joKTia7OGqrs
         9o+38riAnqZcpJoCltLfdkYakuyUj5T8LyB56uZNNhvnEehAlOkRXkQDC8Nkrq2uyniG
         IXaRqxO/EKjx8B8I95u8dUQ97ThNGdDhiAkPuME2SPV/3yOqVwbNQYrfhiNR0f8JP9rz
         am7lW3d/yW2awNw/vwzQoUykSybPMKVLR+qIbc4AuUu20EUxwnsYsDoGABV88fiEVIMA
         gkeCF/hbFJgUWid5B1P8P13GdXjnOayBIhiFKGD+gp182nT5z3MQvM+AWFTebtZJRXPG
         K34Q==
X-Gm-Message-State: ACrzQf20sHJE3dXqfhKB3nJjhxWUzIiAf9/YERRnU0th583uNFlyVtRJ
        rPZKnQWXP4Yzh7RXjkydNtYpXq5gMZVQ+Jz5v175NfOVBmM+KBQNNRFrgeRh2qOLDXscIcEu34y
        vdH3FyZZuxeljpSwzLEG8eLBY
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr2974338wri.455.1665058486720;
        Thu, 06 Oct 2022 05:14:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7osr4ob57IiDmbIrdZi2WLbhXCV2S0D7FjLEDJ56rLLiADTMfPk+gevaJNZ6hcbJxiLz0Hug==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr2974313wri.455.1665058486451;
        Thu, 06 Oct 2022 05:14:46 -0700 (PDT)
Received: from localhost.localdomain ([151.29.60.69])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b003b4e009deb2sm6104722wmq.41.2022.10.06.05.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:14:45 -0700 (PDT)
Date:   Thu, 6 Oct 2022 14:14:43 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <Yz7Gs42TyvZXVEq0@localhost.localdomain>
References: <20221003214501.2050087-1-connoro@google.com>
 <Yz6nA4rY39dB4Wke@localhost.localdomain>
 <Yz6ozjNES7ioCq8C@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz6ozjNES7ioCq8C@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/22 12:07, Peter Zijlstra wrote:
> On Thu, Oct 06, 2022 at 11:59:31AM +0200, Juri Lelli wrote:
> 
> > I think another fundamental question I'm not sure we spent much time on
> > yet is how to deal with rtmutexes.
> 
> Delete them ;-) If PE works, they have no value left.
> 

Oh, OK. :)

