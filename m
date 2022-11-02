Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CF616A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKBRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiKBRLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01E1A04C;
        Wed,  2 Nov 2022 10:11:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q1so16753666pgl.11;
        Wed, 02 Nov 2022 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3FwrdOXirpvuI71plfb4en5QdORvGmwK8vjtjrbqCY=;
        b=aZurwhW5CjSNzRBZFaCtmB1HgWHbhp0eR6jNQW/ObU2vasTqsskyUE45GOd9uNrFnF
         CaWoD33gdMXaB+Z6MTfO+Sqt17DiPuiPP9hwFwdfY4iNa7prRVNAfyRg6mfljD+LU0pe
         V95Jc6FYjucId3PktJyRnmKFLP/EwaVsQv/G9s9xF6fld9czdVJuKBjlnVeRjF0t9JaZ
         9gHUw6Ohv5kU93xsjvOzTXWKzsW4VUWKvnaNYy6sU91glzdAONT10RNlXqZXNL48wgbU
         mOU97X9WoR+c74+TTD1JRWKtxdyNw5EEEFXtt/T7iH+8EgP9C5ygybqRA+ONza0Gmcwp
         RQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3FwrdOXirpvuI71plfb4en5QdORvGmwK8vjtjrbqCY=;
        b=TlvMHP0U8RAu/Xfbf7Clvg5bxJ9We+vrjIhLd+XQ03eUKoXHhSQeIPkVmC0ABOQV3p
         ZGk6e26VHvyBnviw+Uvgw5Eze49FJEbNuaw/VYb+FD0iBW/FvajzAFD8+rNropBsAEZE
         q9i9ZyqRvqgdlldHAVsVSPD+KoIu2VMr8jJJUTR1bW6FzhZkaGJizA/c2Awvleu/17RG
         coOaXV916SU/6+UHQX08YPA/jFNVaikJmv9RzCAKPAaRO0teJDpZhOsfobe0Ubn0VlGG
         KwQvnGh/t+qVOyJ3QqpLGtDWFHbjmXp1zEBh9AzQMKsn1DE1m/WoOYSg95kCEZjQHxlg
         qUGA==
X-Gm-Message-State: ACrzQf24M0IlWpJLWxzuv5RSpUgFWOgh/Kj15ebDCp7BmmRo0A/+Fe84
        gOlXRbgd/kRD/IbzkpgvAI8=
X-Google-Smtp-Source: AMsMyM4rauc2E3YNdM2+SqjDdZDS0uxIT7X9COLIvdi+22KDCynNxHjfjGpWuklSO0EGeInmGAuiPA==
X-Received: by 2002:a62:5486:0:b0:56e:3a98:dcc with SMTP id i128-20020a625486000000b0056e3a980dccmr400740pfb.63.1667409098797;
        Wed, 02 Nov 2022 10:11:38 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id e11-20020a63500b000000b0042fe1914e26sm7793550pgb.37.2022.11.02.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:11:38 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:11:34 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH RE-SEND] media: dvb-core: Fix UAF due to refcount races
 at releasing
Message-ID: <20221102171134.GA491335@ubuntu>
References: <20221031100245.23702-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031100245.23702-1-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear media people,

This CVE-2022-41218 has been a long time since the vulnerability details and PoC code were released:
https://www.openwall.com/lists/oss-security/2022/09/24/1

However, many distros are still vulnerable to this issue.

If you don't mind, could you please tell me the progress of this patch?


Best Regards,
Hyunwoo Kim.
