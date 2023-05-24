Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7570FCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbjEXRo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEXRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:44:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C84E72;
        Wed, 24 May 2023 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=WUCMd7nAkdTG9RTCxIujSC2FhmjjnNJeOfZn/CMRpwQ=; b=hu
        mYlhGm6fmZKdKqUq3Bi1K4cY2SDCzaQ1PpXviPNN1fsQYuGbX4YgxnwoxPSQLNWDY7XWGKBjwTv2J
        oxX+URnxMXC3wpyePSX8hTWwNgsxYjDN/e+ZpIQsC9HDzm4LPlFmiYYapX3DyPlHRr9s1H3hvB3HS
        NUgGHTtmFKjl840=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1sVz-00Dosl-9s; Wed, 24 May 2023 19:43:11 +0200
Date:   Wed, 24 May 2023 19:43:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Kenny Ho <Kenny.Ho@amd.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove hardcoded static string length
Message-ID: <5b1355b8-17f7-49c8-b7b5-3d9ecdb146ce@lunn.ch>
References: <20230523223944.691076-1-Kenny.Ho@amd.com>
 <01936d68-85d3-4d20-9beb-27ff9f62d826@lunn.ch>
 <CAB9dFdt4-cBFhEqsTXk9suE+Bw-xcpM0n3Q6rFmBaa+8A5uMWQ@mail.gmail.com>
 <c0fda91b-1e98-420f-a18a-16bbed25e98d@lunn.ch>
 <CAOWid-erNGD24Ouf4fAJJBqm69QVoHOpNt0E-G+Wt=nq1W4oBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOWid-erNGD24Ouf4fAJJBqm69QVoHOpNt0E-G+Wt=nq1W4oBQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:02:36PM -0400, Kenny Ho wrote:
> On Wed, May 24, 2023 at 12:02 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > So the compiler warning/error needs to be fixed a different want.
> 
> Understood.  Would caping the length at iov_len with a ternary be sufficient?

The quoted text said 'string'. It is not clear if that means c-string,
with a trailing \0. If you just cap iov_len you could end up with a
string which is not terminated.

The other end of the socket should not blow up, because that would be
an obvious DOS or buffer overwrite attack vector. So you need to
decide, do you want to expose such issues and see if anything does
actually blow up, or do you want to do a bit more work and correctly
terminate the string when capped?

	Andrew
