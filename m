Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496973B539
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFWK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:27:08 -0400
Received: from ultron (136.red-2-136-200.staticip.rima-tde.net [2.136.200.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 556C9E9;
        Fri, 23 Jun 2023 03:27:06 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ultron (Postfix) with ESMTP id 9FA581AC5046;
        Fri, 23 Jun 2023 12:13:55 +0200 (CEST)
From:   carlos.fernandez@technica-engineering.de
To:     carlos.fernandez@technica-engineering.de, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Date:   Fri, 23 Jun 2023 12:13:55 +0200
Message-Id: <20230623101355.26790-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZJSnDZL-0hLxbDje@hog>
References: <ZJSnDZL-0hLxbDje@hog>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,SPF_FAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding ES, it is only set if the first 6 octets of the SCI are equal to the MAC, 
in which case SC=0 as well (IEEE802.1AE 9.5 TAG Control information). 
However, if ES=0, it is incorrect to use source MAC as SCI (current implementation)

 
Regarding SC, as said in IEEE 802.1AE 9.9:


"An explicitly encoded SCI field in the SecTAG is not required on point-to-point links, 
which are identified by (...), if the transmitting SecY uses only one transmit SC. 
In that case, the secure association created by the SecY for the peer SecYs, together with
the direction of transmission of the secured MPDU, can be used to identify the transmitting SecY."

 
Therefore the case SC=0 is reserved for cases where both conditions apply: point-to-point links, 
and only one transmit SC. This requirement makes the size of the reception lookup 1.
 

In conclusion, if we're in a NON end station MPDU scenario (ES = 0)  and SCI it's not in the SegTAG (SC = 0), 
we need to find the correct SCI. This can be done by searching it at the current (only) active RX_SC.

Thanks
--
Carlos
