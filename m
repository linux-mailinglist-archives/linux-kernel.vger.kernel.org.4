Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2E5E8D82
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIXOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiIXOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A6D69C9;
        Sat, 24 Sep 2022 07:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E5A761347;
        Sat, 24 Sep 2022 14:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBE9C433D6;
        Sat, 24 Sep 2022 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664030890;
        bh=pnmXa875XedoTgvfdjRiwhXzX75MPM4SzJB1GMVZEvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F3aCBAmFSXOCge8BqkjwP6NdF4TQGKWIanl32QpA48BwKGet1W+LsF5nfRSKTN0ts
         RGrkcFYYHUZqkLhtxSUgF6r5zPzymsg375gmZuqH8uej9Ts2DYchFRiTLOnfrYlguP
         fXOf4WfI1asBa6f082+XCxR3KmcpJKKH1QgJqeGSr0fkzkFMRXP+wLGVV/fyenUpxQ
         lKZMKE6jE/BHFx9c8DLLFaAz54NHSuE+s6nq5O2eRzBnf+iVuHESTlA7GeAgCZCWsN
         BDIWaAt1tzD/A0iaAK3UxUtzbDc+jjpE1XdOO7eDyMUYdh+QkZhEowlDAVYMX9Z+1w
         tZVuAv0EEw1FA==
Date:   Sat, 24 Sep 2022 15:48:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: mcp3911: add support to set PGA
Message-ID: <20220924154817.22868486@jic23-huawei>
In-Reply-To: <CAHp75VdMNTVvk3hu9xSsntU6k6FJceS_4Ou6d-=ozmP3KMARxQ@mail.gmail.com>
References: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
        <a34d9ee8-8bf8-3158-7fe6-cbde513aa1a7@linaro.org>
        <CAHp75VcEGb3kS03QG0ebOJYH1X_D5EbBjL6iNWUxQ5j=aCu29A@mail.gmail.com>
        <2de38167-976b-6996-7929-a41a842991a2@linaro.org>
        <CAHp75VdMNTVvk3hu9xSsntU6k6FJceS_4Ou6d-=ozmP3KMARxQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 12:29:36 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 23, 2022 at 12:24 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 22/09/2022 23:07, Andy Shevchenko wrote:  
> > > On Thu, Sep 22, 2022 at 11:00 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:  
> > >> On 22/09/2022 21:46, Marcus Folkesson wrote:  
> > >
> > > ...
> > >  
> > >> No need to cc-us. Use scripts/get_maintainers.pl.  
> > >
> > > While I understand your point it's much easier to Cc all related
> > > people for all patches in the series, given the fact that many (code)
> > > maintainers ask for that (Cc'ing them all patches). So I prefer to be
> > > on the contributor side for the sake of ease of contribution.  
> >
> > Then please explain me how I am related to this patchset (it's one
> > patch, BTW, not a patchset)...  
> 
> That is a good point! I was under the impression that this is a series
> with some DT changes.

It was originally!  I picked up the whole series, but this last patch
had some issues that 0-day found so I backed it out.  V7 just has
that one patch, so indeed should have had a cleaned up cc list.

Hence the confusion all round!

Jonathan

