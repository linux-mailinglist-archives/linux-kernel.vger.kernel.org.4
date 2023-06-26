Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A173D728
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjFZFb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFZFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:31:24 -0400
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 22:31:18 PDT
Received: from tsukuyomi.43-1.org (tsukuyomi.43-1.org [116.203.33.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D04E44;
        Sun, 25 Jun 2023 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=43-1.org;
 i=@43-1.org; q=dns/txt; s=2019; t=1687756972; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version
 : content-type : from;
 bh=Eq4k6m+p07AiJXh4wBi2hik11r7Xs7nEHyzRzDKtkag=;
 b=NUgI0vT/PM49fItVgX9+3ne7CAVuWcZ2azz+OC2gdh6Z/z8WGBcH1Yxu2BP5PcWdcqbaD
 /2cSrI/nMbkSoBywV/4dBeAUV0gqTOjbhczJkf6pxtSL62RxONgXyONN7SdAses43lUD7iV
 9/Z5rLIfcOgQKth2mnle3+GxAKmBBc0+kaNAMs41Hh0Z3k93LxJ9xKGiEaBrVxiD1ExMrIJ
 y5O1072Sec5G9Inj5ZmPRgiCY+uHJSP3D1fLaNi3CFNo0O1SIauQqfoQdDs3JgEYmD/bbGc
 Uso8ddxYK1WjsR7/f0mqNWy+5TEJ90jlzckIWBD65k4Ua3NzEF8ZLDS2pHtg==
From:   Matthias Maier <tamiko@43-1.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: Kernel oops with netfilter: nf_tables: incorrect error path
 handling with NFT_MSG_NEWRULE
In-Reply-To: <ZJjIRQevLKW+YJP6@calendula> (Pablo Neira Ayuso's message of
        "Mon, 26 Jun 2023 01:05:41 +0200")
References: <87cz1j5tof.fsf@43-1.org> <ZJjIRQevLKW+YJP6@calendula>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Mon, 26 Jun 2023 00:22:51 -0500
Message-ID: <87ttuuajbo.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pablo,

Thanks a lot for the quick reponse!


On Sun, Jun 25, 2023, at 18:05 CDT, Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> [...]
>
> Could you give a try to these two fixes on top?
>
> 26b5a5712eb8 netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
> 4bedf9eee016 netfilter: nf_tables: fix chain binding transaction logic

These two patches alone were not enough, I had to apply the third patch
you mentioned:

> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230625224219.64876-1-pablo@netfilter.org/

With all three patches I do not run into the oops any more.


Nevertheless, please find below a (somehwat minimal) reproducer. Loading
this ruleset into nft_tables via  $ nft -f reproducer.ruleset  previously
oopsed the kernel.

Best,
Matthias



define guarded_ports = {ssh}

table inet portknock {
        set clients_ipv4 {
                type ipv4_addr
                flags timeout
        }

        set candidates_ipv4 {
                type ipv4_addr . inet_service
                flags timeout
        }

        chain input {
                type filter hook input priority -10; policy accept;

                tcp dport 10001 add @candidates_ipv4 {ip  saddr . 10002 timeout 1s}
                tcp dport 10002 ip  saddr . tcp dport @candidates_ipv4 add @candidates_ipv4 {ip  saddr . 10003 timeout 1s}
                tcp dport 10003 ip  saddr . tcp dport @candidates_ipv4 add @candidates_ipv4 {ip  saddr . 10004 timeout 1s}
                tcp dport 10004 ip  saddr . tcp dport @candidates_ipv4 add @candidates_ipv4 {ip  saddr . 10005 timeout 1s}
                tcp dport 10005 ip  saddr . tcp dport @candidates_ipv4 add @clients_ipv4 {ip  saddr timeout 600s} log prefix "Successful portknock: "

                tcp dport $guarded_ports ip  saddr @clients_ipv4 counter accept
                tcp dport $guarded_ports ct state established,related counter accept

                tcp dport $guarded_ports reject with tcp reset
        }
}
