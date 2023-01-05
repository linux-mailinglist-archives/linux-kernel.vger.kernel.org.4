Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BFD65F540
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjAEUeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjAEUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:34:08 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B763D0A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:34:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e21so16641259pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRrUFCrJ0axzfdpreZeRdI/QQfQaUE17V9V5mc2K1ns=;
        b=H/yHivCnjpaZvktvjt0pMyr68l36MjJiIDmL3HoKwpZElMwxfhpNjGV91ULP0Tig9j
         YUu1MytW73O1WRCeyF/CwBTgR3Lr/qxCOc5HbzfbFH4b/bVl4luvl6OxC162dN/rP8Tx
         EUw2FvR70EYQ/x+QZnys1V5nYBRiDC27fUEviBOuSgfmGcZ5wDahHp8wHMGHKEcIIUJe
         FZ5szjgCcADY6q9Jbs/pKIU7rSoXXDpcR5yRNVwVza13yeIMsA3fMj4Cu9v2uv6oQGGC
         wKae0KUUrscdjJhrc7RQ2Rh7C57RyBRsD05LNSHoHyBE3f+cPABJ+FZg3Xj8YddmECSw
         I8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRrUFCrJ0axzfdpreZeRdI/QQfQaUE17V9V5mc2K1ns=;
        b=VmUpTZhGRBLP6zvP52ZpKquM5SDjwQMypkyQOxEM4dEXFvTpAkKRl2xOJ/0y8/DlyW
         oD1lG6WF9Pb4qGLiwGr+TCmb3X8XCzxf+WyR+f4IUhSu3Wr1+sZVRQo/lGzJmuS9VqaI
         evxnLv1ZGtr2+aMCCxNuOhhGsLotuNTOFdIqiRektCfr5rgqzuuAooo8oilRCEQf6X+t
         2AFEoYWmUJHrjqOvWjwVBs7BXkvWZ1Swg5yIDatYWKKG/HB1PBDDNIBTZg+u3qp382K4
         W2xpT0iNz08RTifqJxphlSVHyHlJuq40LF3eHqgxLGCa+IiOraIkClcxn3wNMH8JfQK1
         VrQg==
X-Gm-Message-State: AFqh2kpvhYY0QY3Ek1N40j9bPZ4IcJEBaRKrlX7/7AEozZilVh4xX/+o
        sxLppWp7GYdFv31OsxRtGQhTI/TuWHhwiSJJ
X-Google-Smtp-Source: AMrXdXvJrehsNWGSIB4eCqNf9jo0tej0NF9fj1KpeeVPCJ4V6q5OUmufmgzHcJRz2bWIrXSLbLvfdQ==
X-Received: by 2002:a62:ea01:0:b0:582:bbc7:c61e with SMTP id t1-20020a62ea01000000b00582bbc7c61emr9050199pfh.11.1672950846661;
        Thu, 05 Jan 2023 12:34:06 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g23-20020aa796b7000000b005811082f134sm20408947pfk.158.2023.01.05.12.34.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2023 12:34:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221122071547.165296-1-namit@vmware.com>
Date:   Thu, 5 Jan 2023 12:33:54 -0800
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <48498199-175D-467B-942B-9F8A923B8930@gmail.com>
References: <20221122071547.165296-1-namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2022, at 11:15 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> From: Nadav Amit <namit@vmware.com>
> 
> When SYM_CODE_START_LOCAL() is used, the symbols are local but should be
> saved to the object. In contrast, using ".L" label prefix causes the
> symbols not to be saved in the object.
> 
> Since it is preferable to be able to map instruction pointers back to
> symbols, the local symbol should be saved in the object. Therefore, when
> SYM_CODE_START_LOCAL() is used, the ".L" label prefix should not be
> used.
> 
> Two symbols, however, have both SYM_CODE_START_LOCAL() and ".L" prefix:
> .Lbad_put_user_clac and .Lcopy_user_handle_tail. Remove the ".L" prefix
> from them.
> 
> No functional change, other then emitting these symbols into the object,
> is intended.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>

Ping.


