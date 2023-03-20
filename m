Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7866C09DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjCTFGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCTFGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:06:22 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC61E9EA;
        Sun, 19 Mar 2023 22:06:20 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id n17so7041815uaj.10;
        Sun, 19 Mar 2023 22:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679288779;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Gib55IPNKPDHGsO/r/1AFOaqBwqBE1C5ui0pHqkTWU=;
        b=A9+EFIHSfvLTQUD8yPRYxpH5w1+3fXQyS1sPhRmNfufxNEVjShl9soIBeHrtYn2OuQ
         dywOCnoJMrCJaJ9WxWK9X0+hijatdYIpIUeCB8ERzlM/C2i4xgapDG5b3GR6/1wlCm9o
         c10nA9Q685xpU3vFPTYeHcwaMcLdIPCGOQv/SLwMA8SqPvRVraWz4PbwweVGsCm5URqX
         dVffFebYO35Pfu0vQSTMIZomWLr0pVNsrEbptIoKARj5Mum6o5oIQiyblm2P8y7cMtTy
         zoK3rpjIVarn2N+Narmw/NGhJJA5SXYNP1iW0LxU5mY/J7xrWgRGsZxOkdapPP50yQXn
         rj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679288779;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Gib55IPNKPDHGsO/r/1AFOaqBwqBE1C5ui0pHqkTWU=;
        b=VR7hZwpYO+LjofRaHmvcXOewvd3K/r5lp+yi0hXjEGWK8cA67Ti5JDZqDaMnTev/Z3
         s8JVmTBWsPDB7AHukkyNMyyp24t0w57oHTDKehHgOvKlZNPL05O+gMdHUc+TpzP31kSM
         pG7DNCdGMbRB22TCfHVDzvWMHGQMShjZoOFPB31gdtp6jbyzbTMPJSDnIlnQLRRJyiHT
         Bh51tBxb5n0Y2ErCou1A7zzXuYoiE1n7JZTJu6nw2OJheDp6AJA/VUVWlgakls67KNlh
         QClf3neDNWOijUaGjfwAe+nU0bWcpsdRrObw21/lm03ULm3Zy/pR43cMHzLWA77c6SnG
         /eYA==
X-Gm-Message-State: AO0yUKXIE8Hcfsuo7Qw19ESHQDRB+U1A161fzdZXM+eOih6Y72TgJ/k/
        qyEky7SeDYZhIGKglfsPiIflKVVKhfP/+qk9uO3gwsh2OnA=
X-Google-Smtp-Source: AK7set/LauD6kxENWDuW87+2f6ufLPaM+vYj3cnq/yHfLtx8zE5U70z5GgzowSr+YcHZNHxPsClh8Ev6r9X40hLmTDk=
X-Received: by 2002:a1f:264e:0:b0:401:4daf:d581 with SMTP id
 m75-20020a1f264e000000b004014dafd581mr3197662vkm.0.1679288778914; Sun, 19 Mar
 2023 22:06:18 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Sun, 19 Mar 2023 23:05:52 -0600
Message-ID: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
Subject: RFC - KBUILD_MODNAME is misleading in builtins, as seen in /proc/dynamic_debug/control
To:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic-debug METADATA uses KBUILD_MODNAME as:

#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
        static struct _ddebug  __aligned(8)                     \
        __section("__dyndbg") name = {                          \
                .modname = KBUILD_MODNAME,                      \

This is going amiss for some builtins, ie those enabled here, by:

    echo module main +pmf > /proc/dynamic_debug_control
    grep =pmf /proc/dynamic_debug/control

init/main.c:1187 [main]initcall_blacklist =pmf "blacklisting initcall %s\n"
init/main.c:1226 [main]initcall_blacklisted =pmf "initcall %s blacklisted\n"
init/main.c:1432 [main]run_init_process =pmf "  with arguments:\n"
init/main.c:1434 [main]run_init_process =pmf "    %s\n"
init/main.c:1435 [main]run_init_process =pmf "  with environment:\n"
init/main.c:1437 [main]run_init_process =pmf "    %s\n"
kernel/module/main.c:336 [main]find_symbol =pmf "Failed to find symbol %s\n"
kernel/module/main.c:567 [main]already_uses =pmf "%s uses %s!\n"
kernel/module/main.c:571 [main]already_uses =pmf "%s does not use %s!\n"
kernel/module/main.c:586 [main]add_module_usage =pmf "Allocating new
usage for %s.\n"
kernel/module/main.c:627 [main]module_unload_free =pmf "%s unusing %s\n"
kernel/module/main.c:733 [main]__do_sys_delete_module =pmf "%s already dying\n"
kernel/module/main.c:1345 [main]simplify_symbols =pmf "Common symbol: %s\n"
kernel/module/main.c:1353 [main]simplify_symbols =pmf "Absolute
symbol: 0x%08lx\n"
kernel/module/main.c:1508 [main]__layout_sections =pmf "\t%s\n"
kernel/module/main.c:1526 [main]layout_sections =pmf "Core section
allocation order:\n"
kernel/module/main.c:1529 [main]layout_sections =pmf "Init section
allocation order:\n"
kernel/module/main.c:2168 [main]move_module =pmf "final section addresses:\n"
kernel/module/main.c:2183 [main]move_module =pmf "\t0x%lx %s\n"
kernel/module/main.c:2921 [main]__do_sys_init_module =pmf
"init_module: umod=%p, len=%lu, uargs=%p\n"
kernel/module/main.c:2942 [main]__do_sys_finit_module =pmf
"finit_module: fd=%d, uargs=%p, flags=%i\n"
drivers/base/power/main.c:135 [main]device_pm_add =pmf "Adding info for %s:%s\n"
drivers/base/power/main.c:156 [main]device_pm_remove =pmf "Removing
info for %s:%s\n"
drivers/base/power/main.c:175 [main]device_pm_move_before =pmf "Moving
%s:%s before %s:%s\n"
drivers/base/power/main.c:189 [main]device_pm_move_after =pmf "Moving
%s:%s after %s:%s\n"
drivers/base/power/main.c:202 [main]device_pm_move_last =pmf "Moving
%s:%s to end of list\n"
drivers/base/power/main.c:441 [main]pm_dev_dbg =pmf "PM: %s%s%s driver
flags: %x\n"
drivers/base/power/main.c:467 [main]dpm_show_time =pmf "%s%s%s of
devices %s after %ld.%03ld msecs\n"
bash-5.2#

Basically, KBUILD_MODNAME appears to get basename,
not something specific, set in some config (such as pm, or module)
or cleverly picked out of the path (power is possible)

this compromises the clarity of  dyndbg's module keyword

is some heuristic possible to improve this,
with a manual setting to fix when heuristic fails ?
