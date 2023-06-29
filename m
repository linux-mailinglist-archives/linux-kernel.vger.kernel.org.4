Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E188742697
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjF2Mgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjF2MgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:36:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C931719;
        Thu, 29 Jun 2023 05:36:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3141c3a7547so322438f8f.2;
        Thu, 29 Jun 2023 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688042181; x=1690634181;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKUH0S0w28bkNr/phN4PL7GSXdBXwOj3huBewXtJjxg=;
        b=aQD8uGeW4GkxU7IWOfw7meHAcgJJesTOtsGIHP1F7AASR09TA2urUiSX8KSYYpcB9j
         UNW02WQUi1mcuwEx0hnhXrTMgmtQadAELc6X70xng7Nrtp59jAlyh2eUI4kIQ4eaDI0i
         V1WSs2gaGqbFa/mAa8Dkt3fPzZZ6PXa0vIQDJPqm0txEHixwnDGtQ3YZpM1bYznjkGQo
         LnBZj+hxyjZzakSy8ExRiC412XKVCgyXNa92GZGVOe+J2PkCIAibIh/D9AtWpWM6JgXy
         kjp81eYEqKmzKlAK7l9nJNua0scmR8udqXzuevg+CzNx2es5e5EQxxp8ET7V7TaGl7zd
         iB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042181; x=1690634181;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKUH0S0w28bkNr/phN4PL7GSXdBXwOj3huBewXtJjxg=;
        b=TYFZbtqP0IWyjENgPhdFzLJTWKzYk3iIbiTD9MfZGmjBZQ98WkFoOkmr+yLKmHRnQV
         i7h9yCzBirfWmN4mUYHxmdwStuOH7wvV8g40Ees3pt96xEDM5oe+y2OvmViYT0D64flh
         cmT44Ehh4swK167W6ZKyezSH5T9llQtPdkHEkKg44SVvL68vPBtT95qm+2wggw2Jj64S
         NTbN5hnk1IUXmZuMLJUZR+S3pRDjkfINs16AV1qXmZxZEN0qIgq37ZfzpKSBmMqrC+Y0
         lqhKUWPrIRMVlVTNutaPq0t15YanOr4KNbItN4WGa5pPY2sJkhgS/JZG3r61Ao62Wx71
         ehng==
X-Gm-Message-State: ABy/qLYzVbpUL6KOzYIFym4+odDMSgiuWNIgZEf6IjmLFwJMrgB2AYkk
        oT3wUZ2L84qP1JPcyajImJg=
X-Google-Smtp-Source: APBJJlEVdVpN/BISqZx6WTPbF3QoJThxqXl6TmdlcdBn4g3omb8ZT2ouZEvIaG3xzmoXlbGxTA5RTA==
X-Received: by 2002:adf:fd4e:0:b0:314:1318:18b7 with SMTP id h14-20020adffd4e000000b00314131818b7mr1943643wrs.19.1688042180855;
        Thu, 29 Jun 2023 05:36:20 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d5682000000b00313ec7dd652sm12930949wrv.44.2023.06.29.05.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:36:20 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:36:02 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Message-ID: <20230629123559.GA12573@debian>
References: <20230601160924.GA9194@debian>
 <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 01/06/2023 19:14, Richard Gobert wrote:
> > The GRO control block (NAPI_GRO_CB) is currently at its maximum size.
> > This commit reduces its size by putting two groups of fields that are
> > used only at different times into a union.
> > 
> > Specifically, the fields frag0 and frag0_len are the fields that make up
> > the frag0 optimisation mechanism, which is used during the initial
> > parsing of the SKB.
> > 
> > The fields last and age are used after the initial parsing, while the
> > SKB is stored in the GRO list, waiting for other packets to arrive.
> > 
> > There was one location in dev_gro_receive that modified the frag0 fields
> > after setting last and age. I changed this accordingly without altering
> > the code behaviour.
> > 
> > Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
> Hello Richard,
> 
> I believe this commit broke gro over udp tunnels.
> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
> is pretty much zero.
> 
> Turning off gro on the receiving side (or reverting this commit)
> resolves the issue.

Sorry for the late response.
I am starting to look into it right now. Can you please share more details about your setup?
- I'd like to see the output of these commands:
  ethtool -k
  sysctl net
- The iperf command
- Your network topology
